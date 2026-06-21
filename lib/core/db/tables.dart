import 'package:drift/drift.dart';

/// Companies that own cargo.
class Companies extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  IntColumn get serverId => integer().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('local'))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}

/// Vehicle makes (brands). Built-in entries are seeded on first launch.
class VehicleMakes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(false))();
  BoolColumn get isHidden => boolean().withDefault(const Constant(false))();
}

/// Vehicle models, each belonging to a make. User-added entries grow the dictionary.
class VehicleModels extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text()();
  IntColumn get makeId =>
      integer().references(VehicleMakes, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(false))();
  BoolColumn get isHidden => boolean().withDefault(const Constant(false))();
}

/// Cargo types dictionary (extendable).
class CargoTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text()();
  TextColumn get name => text().withLength(min: 1, max: 150)();
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(false))();
  BoolColumn get isHidden => boolean().withDefault(const Constant(false))();
}

/// Core record: a single vehicle border crossing.
class Crossings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text()();
  IntColumn get companyId => integer().references(Companies, #id)();
  TextColumn get plateNumber => text().withLength(min: 1, max: 40)();
  TextColumn get plateCountry => text()(); // uz | tj
  TextColumn get plateFormatKey => text()();
  IntColumn get makeId => integer().references(VehicleMakes, #id)();
  IntColumn get modelId => integer().references(VehicleModels, #id).nullable()();
  IntColumn get cargoTypeId => integer().references(CargoTypes, #id)();
  RealColumn get cargoQuantity => real().nullable()();
  TextColumn get quantityUnit => text().nullable()();
  DateTimeColumn get crossedAt => dateTime()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  IntColumn get serverId => integer().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('local'))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}

/// Photos attached to a crossing (paths, not bytes).
class CrossingPhotos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text()();
  IntColumn get crossingId =>
      integer().references(Crossings, #id, onDelete: KeyAction.cascade)();
  TextColumn get filePath => text()();
  TextColumn get thumbPath => text()();
  DateTimeColumn get createdAt => dateTime()();
}

/// Immutable audit trail for every create / update / delete.
class ChangeHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get crossingId => integer()();
  TextColumn get changeType => text()(); // create | update | delete
  TextColumn get snapshotJson => text()();
  DateTimeColumn get changedAt => dateTime()();
  TextColumn get changedBy => text().withDefault(const Constant('local'))();
}
