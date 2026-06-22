import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Companies,
    VehicleMakes,
    VehicleModels,
    CargoTypes,
    Crossings,
    CrossingCargos,
    CrossingPhotos,
    ChangeHistory,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _createIndexes();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(crossings, crossings.latitude);
            await m.addColumn(crossings, crossings.longitude);
          }
          if (from < 3) {
            // Move the single cargo into the new one-to-many table, then drop
            // the old cargo columns and relax the plate columns to nullable.
            await m.createTable(crossingCargos);
            await customStatement(
              'INSERT INTO crossing_cargos '
              '(uuid, crossing_id, cargo_type_id, quantity, unit, created_at) '
              'SELECT lower(hex(randomblob(16))), id, cargo_type_id, '
              'cargo_quantity, quantity_unit, created_at FROM crossings',
            );
            await m.alterTable(TableMigration(crossings));
            // alterTable rebuilds the table and drops its old indexes.
            await _createIndexes();
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  Future<void> _createIndexes() async {
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_cross_company ON crossings(company_id)');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_cross_plate ON crossings(plate_number)');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_cross_time ON crossings(crossed_at)');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_cross_make ON crossings(make_id)');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_cargo_crossing ON crossing_cargos(crossing_id)');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_cargo_type ON crossing_cargos(cargo_type_id)');
  }

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'customs_control.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }

  // ---------------------------------------------------------------------------
  // Append an immutable audit entry.
  // ---------------------------------------------------------------------------
  Future<void> recordHistory(
    int crossingId,
    String changeType,
    Map<String, dynamic> snapshot,
  ) {
    return into(changeHistory).insert(
      ChangeHistoryCompanion.insert(
        crossingId: crossingId,
        changeType: changeType,
        snapshotJson: jsonEncode(snapshot),
        changedAt: DateTime.now(),
      ),
    );
  }

  Future<List<ChangeHistoryData>> historyFor(int crossingId) {
    return (select(changeHistory)
          ..where((t) => t.crossingId.equals(crossingId))
          ..orderBy([(t) => OrderingTerm.desc(t.changedAt)]))
        .get();
  }
}
