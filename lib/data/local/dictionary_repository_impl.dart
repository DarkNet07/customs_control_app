import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:uuid/uuid.dart';

import '../../core/db/app_database.dart';
import '../../domain/repositories/repositories.dart';

class LocalDictionaryRepository implements DictionaryRepository {
  LocalDictionaryRepository(this.db);

  final AppDatabase db;
  final _uuid = const Uuid();

  @override
  Future<void> seedIfEmpty() async {
    final makeCount = await db.vehicleMakes.count().getSingle();
    if (makeCount > 0) return;

    final raw = await rootBundle.loadString('assets/seed/vehicles.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;

    await db.transaction(() async {
      for (final makeJson in (data['makes'] as List)) {
        final make = makeJson as Map<String, dynamic>;
        final makeId = await db.into(db.vehicleMakes).insert(
              VehicleMakesCompanion.insert(
                uuid: _uuid.v4(),
                name: make['name'] as String,
                isBuiltIn: const Value(true),
              ),
            );
        for (final model in (make['models'] as List).cast<String>()) {
          await db.into(db.vehicleModels).insert(
                VehicleModelsCompanion.insert(
                  uuid: _uuid.v4(),
                  makeId: makeId,
                  name: model,
                  isBuiltIn: const Value(true),
                ),
              );
        }
      }
      for (final cargo in (data['cargoTypes'] as List).cast<String>()) {
        await db.into(db.cargoTypes).insert(
              CargoTypesCompanion.insert(
                uuid: _uuid.v4(),
                name: cargo,
                isBuiltIn: const Value(true),
              ),
            );
      }
    });
  }

  // -------------------- makes --------------------
  @override
  Stream<List<VehicleMake>> watchMakes() {
    return (db.select(db.vehicleMakes)
          ..where((t) => t.isHidden.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch();
  }

  @override
  Future<List<VehicleMake>> getMakes() {
    return (db.select(db.vehicleMakes)
          ..where((t) => t.isHidden.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  @override
  Future<int> addMake(String name) {
    return db.into(db.vehicleMakes).insert(
          VehicleMakesCompanion.insert(uuid: _uuid.v4(), name: name.trim()),
        );
  }

  // -------------------- models --------------------
  @override
  Stream<List<VehicleModel>> watchModels(int makeId) {
    return (db.select(db.vehicleModels)
          ..where((t) => t.makeId.equals(makeId) & t.isHidden.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch();
  }

  @override
  Future<List<VehicleModel>> getModels(int makeId) {
    return (db.select(db.vehicleModels)
          ..where((t) => t.makeId.equals(makeId) & t.isHidden.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  @override
  Future<int> addModel(int makeId, String name) {
    return db.into(db.vehicleModels).insert(
          VehicleModelsCompanion.insert(
            uuid: _uuid.v4(),
            makeId: makeId,
            name: name.trim(),
          ),
        );
  }

  // -------------------- cargo types --------------------
  @override
  Stream<List<CargoType>> watchCargoTypes() {
    return (db.select(db.cargoTypes)
          ..where((t) => t.isHidden.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch();
  }

  @override
  Future<List<CargoType>> getCargoTypes() {
    return (db.select(db.cargoTypes)
          ..where((t) => t.isHidden.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  @override
  Future<int> addCargoType(String name) {
    return db.into(db.cargoTypes).insert(
          CargoTypesCompanion.insert(uuid: _uuid.v4(), name: name.trim()),
        );
  }
}
