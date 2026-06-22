import '../../core/db/app_database.dart';

/// One cargo line of a crossing: a cargo type with optional quantity and unit.
class CargoLine {
  const CargoLine({
    required this.cargoTypeId,
    required this.cargoTypeName,
    this.quantity,
    this.unit,
  });

  final int cargoTypeId;
  final String cargoTypeName;
  final double? quantity;
  final String? unit;

  String get quantityLabel {
    if (quantity == null) return '';
    final q = quantity!;
    final num = q == q.roundToDouble() ? q.toStringAsFixed(0) : '$q';
    return '$num ${unit ?? ''}'.trim();
  }
}

/// A crossing with its resolved dictionary names, cargo lines and photos.
class CrossingView {
  const CrossingView({
    required this.crossing,
    required this.companyName,
    required this.makeName,
    required this.modelName,
    required this.cargos,
    required this.photos,
  });

  final Crossing crossing;
  final String companyName;
  final String makeName;
  final String? modelName;
  final List<CargoLine> cargos;
  final List<CrossingPhoto> photos;

  String get vehicleLabel =>
      modelName == null ? makeName : '$makeName $modelName';

  bool get hasPlate => crossing.plateNumber != null;

  /// Comma-separated cargo type names.
  String get cargoSummary => cargos.map((c) => c.cargoTypeName).join(', ');
}
