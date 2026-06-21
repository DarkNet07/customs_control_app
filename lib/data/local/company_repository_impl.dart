import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/db/app_database.dart';
import '../../domain/repositories/repositories.dart';

class LocalCompanyRepository implements CompanyRepository {
  LocalCompanyRepository(this.db);

  final AppDatabase db;
  final _uuid = const Uuid();

  SimpleSelectStatement<$CompaniesTable, Company> _base() =>
      db.select(db.companies)..where((t) => t.isDeleted.equals(false));

  @override
  Stream<List<Company>> watchAll() {
    return (_base()..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();
  }

  @override
  Future<List<Company>> getAll() {
    return (_base()..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
  }

  @override
  Future<Company> getOrCreate(String name) async {
    final trimmed = name.trim();
    final existing = await (db.select(db.companies)
          ..where((t) =>
              t.name.lower().equals(trimmed.toLowerCase()) &
              t.isDeleted.equals(false)))
        .getSingleOrNull();
    if (existing != null) return existing;
    final id = await add(trimmed);
    return (db.select(db.companies)..where((t) => t.id.equals(id))).getSingle();
  }

  @override
  Future<int> add(String name) {
    final now = DateTime.now();
    return db.into(db.companies).insert(
          CompaniesCompanion.insert(
            uuid: _uuid.v4(),
            name: name.trim(),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  @override
  Future<void> rename(int id, String name) async {
    await (db.update(db.companies)..where((t) => t.id.equals(id))).write(
      CompaniesCompanion(
        name: Value(name.trim()),
        updatedAt: Value(DateTime.now()),
        syncStatus: const Value('dirty'),
      ),
    );
  }

  @override
  Future<void> softDelete(int id) async {
    await (db.update(db.companies)..where((t) => t.id.equals(id))).write(
      CompaniesCompanion(
        isDeleted: const Value(true),
        updatedAt: Value(DateTime.now()),
        syncStatus: const Value('dirty'),
      ),
    );
  }
}
