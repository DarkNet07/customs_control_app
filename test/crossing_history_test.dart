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

  Future<int> seedAndCreate({
    String? plate = '01 A 123 BC',
    List<CargoInput>? cargos,
  }) async {
    final companyId = await companies.add('Acme');
    final makeId = await dict.addMake('Daewoo');
    final modelId = await dict.addModel(makeId, 'Damas');
    final cargoId = await dict.addCargoType('Овощи');
    return crossings.create(CrossingInput(
      companyId: companyId,
      plateNumber: plate,
      plateCountry: plate == null ? null : 'uz',
      plateFormatKey: plate == null ? null : 'uz_standard',
      makeId: makeId,
      modelId: modelId,
      cargos: cargos ?? [CargoInput(cargoTypeId: cargoId, quantity: 10, unit: 'т')],
      crossedAt: DateTime(2026, 1, 1, 10),
    ));
  }

  test('create records a history entry', () async {
    final id = await seedAndCreate();
    final history = await crossings.history(id);
    expect(history.length, 1);
    expect(history.first.changeType, 'create');
  });

  test('several cargo lines are saved and read back', () async {
    final companyId = await companies.add('Acme');
    final makeId = await dict.addMake('Daewoo');
    final c1 = await dict.addCargoType('Овощи');
    final c2 = await dict.addCargoType('Текстиль');
    final id = await crossings.create(CrossingInput(
      companyId: companyId,
      plateNumber: '01 A 123 BC',
      plateCountry: 'uz',
      plateFormatKey: 'uz_standard',
      makeId: makeId,
      modelId: null,
      cargos: [
        CargoInput(cargoTypeId: c1, quantity: 10, unit: 'т'),
        CargoInput(cargoTypeId: c2),
      ],
      crossedAt: DateTime(2026, 1, 1, 10),
    ));
    final view = await crossings.getById(id);
    expect(view!.cargos.length, 2);
    expect(view.cargos.map((c) => c.cargoTypeName),
        containsAll(['Овощи', 'Текстиль']));
  });

  test('record without a plate is saved and read back', () async {
    final id = await seedAndCreate(plate: null);
    final view = await crossings.getById(id);
    expect(view!.crossing.plateNumber, isNull);
    expect(view.hasPlate, isFalse);
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
        cargos: [CargoInput(cargoTypeId: view.cargos.first.cargoTypeId)],
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
