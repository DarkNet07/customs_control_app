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
  // Read with joins, search, filters, sorting.
  // ---------------------------------------------------------------------------
  JoinedSelectStatement _joined(CrossingQuery q) {
    final c = db.crossings;
    final company = db.companies;
    final make = db.vehicleMakes;
    final model = db.vehicleModels;
    final cargo = db.cargoTypes;

    final query = db.select(c).join([
      innerJoin(company, company.id.equalsExp(c.companyId)),
      innerJoin(make, make.id.equalsExp(c.makeId)),
      leftOuterJoin(model, model.id.equalsExp(c.modelId)),
      innerJoin(cargo, cargo.id.equalsExp(c.cargoTypeId)),
    ]);

    final filters = <Expression<bool>>[c.isDeleted.equals(false)];

    if (q.companyId != null) filters.add(c.companyId.equals(q.companyId!));
    if (q.makeId != null) filters.add(c.makeId.equals(q.makeId!));
    if (q.cargoTypeId != null) {
      filters.add(c.cargoTypeId.equals(q.cargoTypeId!));
    }
    if (q.from != null) {
      filters.add(c.crossedAt.isBiggerOrEqualValue(q.from!));
    }
    if (q.to != null) filters.add(c.crossedAt.isSmallerOrEqualValue(q.to!));

    if (q.search.trim().isNotEmpty) {
      final term = '%${q.search.trim().toLowerCase()}%';
      filters.add(c.plateNumber.lower().like(term) |
          company.name.lower().like(term) |
          make.name.lower().like(term) |
          model.name.lower().like(term) |
          cargo.name.lower().like(term));
    }

    query.where(filters.reduce((a, b) => a & b));

    final asc = q.direction == SortDirection.asc;
    OrderingTerm term(Expression<Object> e) =>
        asc ? OrderingTerm.asc(e) : OrderingTerm.desc(e);
    switch (q.sort) {
      case CrossingSort.company:
        query.orderBy([term(company.name)]);
      case CrossingSort.make:
        query.orderBy([term(make.name)]);
      case CrossingSort.plate:
        query.orderBy([term(c.plateNumber)]);
      case CrossingSort.time:
        query.orderBy([term(c.crossedAt)]);
      case CrossingSort.cargo:
        query.orderBy([term(cargo.name)]);
    }
    return query;
  }

  Future<List<CrossingView>> _mapRows(List<TypedResult> rows) async {
    if (rows.isEmpty) return [];
    final crossings = rows
        .map((r) => r.readTable(db.crossings))
        .toList();
    final ids = crossings.map((c) => c.id).toList();
    final photos = await (db.select(db.crossingPhotos)
          ..where((t) => t.crossingId.isIn(ids))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
    final byCrossing = <int, List<CrossingPhoto>>{};
    for (final ph in photos) {
      byCrossing.putIfAbsent(ph.crossingId, () => []).add(ph);
    }

    return rows.map((r) {
      final cr = r.readTable(db.crossings);
      final model = r.readTableOrNull(db.vehicleModels);
      return CrossingView(
        crossing: cr,
        companyName: r.readTable(db.companies).name,
        makeName: r.readTable(db.vehicleMakes).name,
        modelName: model?.name,
        cargoTypeName: r.readTable(db.cargoTypes).name,
        photos: byCrossing[cr.id] ?? const [],
      );
    }).toList();
  }

  @override
  Stream<List<CrossingView>> watchCrossings(CrossingQuery query) {
    return _joined(query).watch().asyncMap(_mapRows);
  }

  @override
  Future<CrossingView?> getById(int id) async {
    final c = db.crossings;
    final query = db.select(c).join([
      innerJoin(db.companies, db.companies.id.equalsExp(c.companyId)),
      innerJoin(db.vehicleMakes, db.vehicleMakes.id.equalsExp(c.makeId)),
      leftOuterJoin(db.vehicleModels, db.vehicleModels.id.equalsExp(c.modelId)),
      innerJoin(db.cargoTypes, db.cargoTypes.id.equalsExp(c.cargoTypeId)),
    ])
      ..where(c.id.equals(id));
    final rows = await query.get();
    final mapped = await _mapRows(rows);
    return mapped.isEmpty ? null : mapped.first;
  }

  @override
  Future<List<CrossingView>> getAllForExport({DateTime? from, DateTime? to}) {
    return _joined(CrossingQuery(
      from: from,
      to: to,
      sort: CrossingSort.time,
      direction: SortDirection.desc,
    )).get().then(_mapRows);
  }

  // ---------------------------------------------------------------------------
  // Mutations (with audit history).
  // ---------------------------------------------------------------------------
  CrossingsCompanion _companion(CrossingInput i, {required DateTime now}) {
    return CrossingsCompanion.insert(
      uuid: _uuid.v4(),
      companyId: i.companyId,
      plateNumber: i.plateNumber.trim().toUpperCase(),
      plateCountry: i.plateCountry,
      plateFormatKey: i.plateFormatKey,
      makeId: i.makeId,
      modelId: Value(i.modelId),
      cargoTypeId: i.cargoTypeId,
      cargoQuantity: Value(i.cargoQuantity),
      quantityUnit: Value(i.quantityUnit),
      crossedAt: i.crossedAt,
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
      await _insertPhotos(id, input);
      final view = await getById(id);
      await db.recordHistory(id, 'create', _snapshot(view));
      return id;
    });
  }

  @override
  Future<void> update(int id, CrossingInput input) async {
    await db.transaction(() async {
      final before = await getById(id);
      await db.recordHistory(id, 'update', _snapshot(before));

      await (db.update(db.crossings)..where((t) => t.id.equals(id))).write(
        CrossingsCompanion(
          companyId: Value(input.companyId),
          plateNumber: Value(input.plateNumber.trim().toUpperCase()),
          plateCountry: Value(input.plateCountry),
          plateFormatKey: Value(input.plateFormatKey),
          makeId: Value(input.makeId),
          modelId: Value(input.modelId),
          cargoTypeId: Value(input.cargoTypeId),
          cargoQuantity: Value(input.cargoQuantity),
          quantityUnit: Value(input.quantityUnit),
          crossedAt: Value(input.crossedAt),
          note: Value(input.note),
          updatedAt: Value(DateTime.now()),
          syncStatus: const Value('dirty'),
        ),
      );

      // Replace photos with the new set.
      await (db.delete(db.crossingPhotos)
            ..where((t) => t.crossingId.equals(id)))
          .go();
      await _insertPhotos(id, input);
    });
  }

  @override
  Future<void> softDelete(int id) async {
    await db.transaction(() async {
      final before = await getById(id);
      await db.recordHistory(id, 'delete', _snapshot(before));
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

  Map<String, dynamic> _snapshot(CrossingView? v) {
    if (v == null) return {};
    final c = v.crossing;
    return {
      'plateNumber': c.plateNumber,
      'plateCountry': c.plateCountry,
      'company': v.companyName,
      'vehicle': v.vehicleLabel,
      'cargoType': v.cargoTypeName,
      'cargoQuantity': c.cargoQuantity,
      'quantityUnit': c.quantityUnit,
      'crossedAt': c.crossedAt.toIso8601String(),
      'note': c.note,
      'photos': v.photos.length,
    };
  }
}
