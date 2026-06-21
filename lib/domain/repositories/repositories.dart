import '../../core/db/app_database.dart';
import '../models/crossing_view.dart';
import '../models/query_options.dart';

/// Data needed to create or update a crossing.
class CrossingInput {
  CrossingInput({
    required this.companyId,
    required this.plateNumber,
    required this.plateCountry,
    required this.plateFormatKey,
    required this.makeId,
    required this.modelId,
    required this.cargoTypeId,
    required this.crossedAt,
    this.cargoQuantity,
    this.quantityUnit,
    this.note,
    this.photoPaths = const [],
  });

  final int companyId;
  final String plateNumber;
  final String plateCountry;
  final String plateFormatKey;
  final int makeId;
  final int? modelId;
  final int cargoTypeId;
  final DateTime crossedAt;
  final double? cargoQuantity;
  final String? quantityUnit;
  final String? note;

  /// Pairs of (compressed file path, thumbnail path).
  final List<({String filePath, String thumbPath})> photoPaths;
}

abstract class CrossingRepository {
  Stream<List<CrossingView>> watchCrossings(CrossingQuery query);
  Future<CrossingView?> getById(int id);
  Future<int> create(CrossingInput input);
  Future<void> update(int id, CrossingInput input);
  Future<void> softDelete(int id);
  Future<List<ChangeHistoryData>> history(int crossingId);
  Future<List<CrossingView>> getAllForExport({DateTime? from, DateTime? to});
}

abstract class CompanyRepository {
  Stream<List<Company>> watchAll();
  Future<List<Company>> getAll();
  Future<Company> getOrCreate(String name);
  Future<int> add(String name);
  Future<void> rename(int id, String name);
  Future<void> softDelete(int id);
}

abstract class DictionaryRepository {
  Future<void> seedIfEmpty();

  Stream<List<VehicleMake>> watchMakes();
  Future<List<VehicleMake>> getMakes();
  Future<int> addMake(String name);

  Stream<List<VehicleModel>> watchModels(int makeId);
  Future<List<VehicleModel>> getModels(int makeId);
  Future<int> addModel(int makeId, String name);

  Stream<List<CargoType>> watchCargoTypes();
  Future<List<CargoType>> getCargoTypes();
  Future<int> addCargoType(String name);
}
