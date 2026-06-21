import 'package:customs_control_app/core/db/app_database.dart';
import 'package:customs_control_app/data/local/company_repository_impl.dart';
import 'package:customs_control_app/data/local/crossing_repository_impl.dart';
import 'package:customs_control_app/data/local/dictionary_repository_impl.dart';
import 'package:customs_control_app/domain/repositories/repositories.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late LocalCrossingRepository crossings;
  late LocalCompanyRepository companies;
  late LocalDictionaryRepository dict;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    crossings = LocalCrossingRepository(db);
    companies = LocalCompanyRepository(db);
    dict = LocalDictionaryRepository(db);
  });

  tearDown(() => db.close());

  Future<int> seedAndCreate() async {
    final companyId = await companies.add('Acme');
    final makeId = await dict.addMake('Daewoo');
    final modelId = await dict.addModel(makeId, 'Damas');
    final cargoId = await dict.addCargoType('Овощи');
    return crossings.create(CrossingInput(
      companyId: companyId,
      plateNumber: '01 A 123 BC',
      plateCountry: 'uz',
      plateFormatKey: 'uz_standard',
      makeId: makeId,
      modelId: modelId,
      cargoTypeId: cargoId,
      crossedAt: DateTime(2026, 1, 1, 10),
    ));
  }

  test('create records a history entry', () async {
    final id = await seedAndCreate();
    final history = await crossings.history(id);
    expect(history.length, 1);
    expect(history.first.changeType, 'create');
  });

  test('update appends history and changes data', () async {
    final id = await seedAndCreate();
    final view = await crossings.getById(id);
    await crossings.update(
      id,
      CrossingInput(
        companyId: view!.crossing.companyId,
        plateNumber: '01 A 999 ZZ',
        plateCountry: 'uz',
        plateFormatKey: 'uz_standard',
        makeId: view.crossing.makeId,
        modelId: view.crossing.modelId,
        cargoTypeId: view.crossing.cargoTypeId,
        crossedAt: view.crossing.crossedAt,
      ),
    );
    final updated = await crossings.getById(id);
    expect(updated!.crossing.plateNumber, '01 A 999 ZZ');
    final history = await crossings.history(id);
    expect(history.length, 2); // create + update
  });

  test('soft delete hides record but keeps history', () async {
    final id = await seedAndCreate();
    await crossings.softDelete(id);
    final list = await crossings.getAllForExport();
    expect(list.where((v) => v.crossing.id == id), isEmpty);
    final history = await crossings.history(id);
    expect(history.any((h) => h.changeType == 'delete'), isTrue);
  });
}
