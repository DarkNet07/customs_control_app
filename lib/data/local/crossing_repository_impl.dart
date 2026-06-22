import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/db/app_database.dart';
import '../../domain/models/crossing_view.dart';
import '../../domain/models/query_options.dart';
import '../../domain/repositories/repositories.dart';

class LocalCrossingRepository implements CrossingRepository {
  LocalCrossingRepository(this.db);

  final AppDatabase db;
  final _uuid = const Uuid();

  // ---------------------------------------------------------------------------
  // Read: SQL handles joins + non-cargo filters; cargo filter/search/sort are
  // applied in Dart (cargo is now one-to-many).
  // ---------------------------------------------------------------------------
  JoinedSelectStatement _baseQuery({
    int? companyId,
    int? makeId,
    DateTime? from,
    DateTime? to,
  }) {
    final c = db.crossings;
    final company = db.companies;
    final make = db.vehicleMakes;
    final model = db.vehicleModels;

    final query = db.select(c).join([
      innerJoin(company, company.id.equalsExp(c.companyId)),
      innerJoin(make, make.id.equalsExp(c.makeId)),
      leftOuterJoin(model, model.id.equalsExp(c.modelId)),
    ]);

    final filters = <Expression<bool>>[c.isDeleted.equals(false)];
    if (companyId != null) filters.add(c.companyId.equals(companyId));
    if (makeId != null) filters.add(c.makeId.equals(makeId));
    if (from != null) filters.add(c.crossedAt.isBiggerOrEqualValue(from));
    if (to != null) filters.add(c.crossedAt.isSmallerOrEqualValue(to));
    query.where(filters.reduce((a, b) => a & b));
    query.orderBy([OrderingTerm.desc(c.crossedAt)]);
    return query;
  }

  Future<List<CrossingView>> _mapRows(List<TypedResult> rows) async {
    if (rows.isEmpty) return [];
    final ids = rows.map((r) => r.readTable(db.crossings).id).toList();

    final photos = await (db.select(db.crossingPhotos)
          ..where((t) => t.crossingId.isIn(ids))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
    final photosBy = <int, List<CrossingPhoto>>{};
    for (final ph in photos) {
      photosBy.putIfAbsent(ph.crossingId, () => []).add(ph);
    }

    final cc = db.crossingCargos;
    final ct = db.cargoTypes;
    final cargoRows = await (db.select(cc).join([
      innerJoin(ct, ct.id.equalsExp(cc.cargoTypeId)),
    ])
          ..where(cc.crossingId.isIn(ids))
          ..orderBy([OrderingTerm.asc(cc.createdAt), OrderingTerm.asc(cc.id)]))
        .get();
    final cargosBy = <int, List<CargoLine>>{};
    for (final r in cargoRows) {
      final row = r.readTable(cc);
      cargosBy.putIfAbsent(row.crossingId, () => []).add(
            CargoLine(
              cargoTypeId: row.cargoTypeId,
              cargoTypeName: r.readTable(ct).name,
              quantity: row.quantity,
              unit: row.unit,
            ),
          );
    }

    return rows.map((r) {
      final cr = r.readTable(db.crossings);
      final model = r.readTableOrNull(db.vehicleModels);
      return CrossingView(
        crossing: cr,
        companyName: r.readTable(db.companies).name,
        makeName: r.readTable(db.vehicleMakes).name,
        modelName: model?.name,
        cargos: cargosBy[cr.id] ?? const [],
        photos: photosBy[cr.id] ?? const [],
      );
    }).toList();
  }

  List<CrossingView> _postProcess(List<CrossingView> list, CrossingQuery q) {
    var result = list;

    if (q.cargoTypeId != null) {
      result = result
          .where((v) => v.cargos.any((c) => c.cargoTypeId == q.cargoTypeId))
          .toList();
    }

    final term = q.search.trim().toLowerCase();
    if (term.isNotEmpty) {
      result = result.where((v) {
        final hay = [
          v.crossing.plateNumber ?? '',
          v.companyName,
          v.makeName,
          v.modelName ?? '',
          ...v.cargos.map((c) => c.cargoTypeName),
        ].join(' ').toLowerCase();
        return hay.contains(term);
      }).toList();
    }

    int cmp(CrossingView a, CrossingView b) => switch (q.sort) {
          CrossingSort.company =>
            a.companyName.toLowerCase().compareTo(b.companyName.toLowerCase()),
          CrossingSort.make =>
            a.makeName.toLowerCase().compareTo(b.makeName.toLowerCase()),
          CrossingSort.plate => (a.crossing.plateNumber ?? '')
              .compareTo(b.crossing.plateNumber ?? ''),
          CrossingSort.time =>
            a.crossing.crossedAt.compareTo(b.crossing.crossedAt),
          CrossingSort.cargo =>
            a.cargoSummary.toLowerCase().compareTo(b.cargoSummary.toLowerCase()),
        };

    result = [...result]..sort(cmp);
    if (q.direction == SortDirection.desc) result = result.reversed.toList();
    return result;
  }

  @override
  Stream<List<CrossingView>> watchCrossings(CrossingQuery query) {
    return _baseQuery(
      companyId: query.companyId,
      makeId: query.makeId,
      from: query.from,
      to: query.to,
    ).watch().asyncMap(_mapRows).map((list) => _postProcess(list, query));
  }

  @override
  Future<CrossingView?> getById(int id) async {
    final c = db.crossings;
    final query = db.select(c).join([
      innerJoin(db.companies, db.companies.id.equalsExp(c.companyId)),
      innerJoin(db.vehicleMakes, db.vehicleMakes.id.equalsExp(c.makeId)),
      leftOuterJoin(db.vehicleModels, db.vehicleModels.id.equalsExp(c.modelId)),
    ])
      ..where(c.id.equals(id));
    final rows = await query.get();
    final mapped = await _mapRows(rows);
    return mapped.isEmpty ? null : mapped.first;
  }

  @override
  Future<List<CrossingView>> getAllForExport({DateTime? from, DateTime? to}) {
    return _baseQuery(from: from, to: to).get().then(_mapRows);
  }

  // ---------------------------------------------------------------------------
  // Mutations (with audit history).
  // ---------------------------------------------------------------------------
  CrossingsCompanion _companion(CrossingInput i, {required DateTime now}) {
    return CrossingsCompanion.insert(
      uuid: _uuid.v4(),
      companyId: i.companyId,
      plateNumber: Value(i.plateNumber?.trim().toUpperCase()),
      plateCountry: Value(i.plateCountry),
      plateFormatKey: Value(i.plateFormatKey),
      makeId: i.makeId,
      modelId: Value(i.modelId),
      crossedAt: i.crossedAt,
      latitude: Value(i.latitude),
      longitude: Value(i.longitude),
      note: Value(i.note),
      createdAt: now,
      updatedAt: now,
    );
  }

  @override
  Future<int> create(CrossingInput input) async {
    return db.transaction(() async {
      final now = DateTime.now();
      final id =
          await db.into(db.crossings).insert(_companion(input, now: now));
      await _insertCargos(id, input);
      await _insertPhotos(id, input);
      final view = await getById(id);
      await db.recordHistory(id, 'create', _createSnap(view));
      return id;
    });
  }

  @override
  Future<void> update(int id, CrossingInput input) async {
    await db.transaction(() async {
      final before = await getById(id);

      await (db.update(db.crossings)..where((t) => t.id.equals(id))).write(
        CrossingsCompanion(
          companyId: Value(input.companyId),
          plateNumber: Value(input.plateNumber?.trim().toUpperCase()),
          plateCountry: Value(input.plateCountry),
          plateFormatKey: Value(input.plateFormatKey),
          makeId: Value(input.makeId),
          modelId: Value(input.modelId),
          crossedAt: Value(input.crossedAt),
          latitude: Value(input.latitude),
          longitude: Value(input.longitude),
          note: Value(input.note),
          updatedAt: Value(DateTime.now()),
          syncStatus: const Value('dirty'),
        ),
      );

      // Replace cargo lines and photos with the new sets.
      await (db.delete(db.crossingCargos)
            ..where((t) => t.crossingId.equals(id)))
          .go();
      await _insertCargos(id, input);
      await (db.delete(db.crossingPhotos)
            ..where((t) => t.crossingId.equals(id)))
          .go();
      await _insertPhotos(id, input);

      final after = await getById(id);
      await db.recordHistory(id, 'update', _updateSnap(before, after));
    });
  }

  @override
  Future<void> softDelete(int id) async {
    await db.transaction(() async {
      final before = await getById(id);
      await db.recordHistory(id, 'delete', _deleteSnap(before));
      await (db.update(db.crossings)..where((t) => t.id.equals(id))).write(
        CrossingsCompanion(
          isDeleted: const Value(true),
          updatedAt: Value(DateTime.now()),
          syncStatus: const Value('dirty'),
        ),
      );
    });
  }

  @override
  Future<List<ChangeHistoryData>> history(int crossingId) =>
      db.historyFor(crossingId);

  Future<void> _insertCargos(int crossingId, CrossingInput input) async {
    final now = DateTime.now();
    for (final cg in input.cargos) {
      await db.into(db.crossingCargos).insert(
            CrossingCargosCompanion.insert(
              uuid: _uuid.v4(),
              crossingId: crossingId,
              cargoTypeId: cg.cargoTypeId,
              quantity: Value(cg.quantity),
              unit: Value(cg.unit),
              createdAt: now,
            ),
          );
    }
  }

  Future<void> _insertPhotos(int crossingId, CrossingInput input) async {
    final now = DateTime.now();
    for (final ph in input.photoPaths) {
      await db.into(db.crossingPhotos).insert(
            CrossingPhotosCompanion.insert(
              uuid: _uuid.v4(),
              crossingId: crossingId,
              filePath: ph.filePath,
              thumbPath: ph.thumbPath,
              createdAt: now,
            ),
          );
    }
  }

  /// Flat, comparable field values for a crossing (used to diff revisions).
  Map<String, String?> _flat(CrossingView? v) {
    if (v == null) return {};
    final c = v.crossing;
    return {
      'plateNumber': c.plateNumber,
      'company': v.companyName,
      'vehicle': v.vehicleLabel,
      'cargo': v.cargos
          .map((cg) => [cg.cargoTypeName, cg.quantityLabel]
              .where((s) => s.isNotEmpty)
              .join(' '))
          .join('; '),
      'crossedAt': c.crossedAt.toIso8601String(),
      'note': c.note,
      'photos': v.photos.length.toString(),
    };
  }

  /// Create: every field as `from: null → to: value`.
  Map<String, dynamic> _createSnap(CrossingView? v) {
    final flat = _flat(v);
    return {
      'plateCountry': v?.crossing.plateCountry,
      'changes': {
        for (final e in flat.entries)
          if (e.value != null && e.value!.isNotEmpty)
            e.key: {'from': null, 'to': e.value},
      },
    };
  }

  /// Update: only the fields whose value changed (before → after).
  Map<String, dynamic> _updateSnap(CrossingView? before, CrossingView? after) {
    final a = _flat(before);
    final b = _flat(after);
    final changes = <String, dynamic>{};
    for (final key in b.keys) {
      if (a[key] != b[key]) {
        changes[key] = {'from': a[key], 'to': b[key]};
      }
    }
    return {
      'plateCountry': after?.crossing.plateCountry,
      'changes': changes,
    };
  }

  /// Delete: no field list, just keep country for context.
  Map<String, dynamic> _deleteSnap(CrossingView? before) {
    return {
      'plateCountry': before?.crossing.plateCountry,
      'changes': <String, dynamic>{},
    };
  }
}
