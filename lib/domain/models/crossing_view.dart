import '../../core/db/app_database.dart';

/// A crossing with its resolved dictionary names and photos, ready for display.
class CrossingView {
  const CrossingView({
    required this.crossing,
    required this.companyName,
    required this.makeName,
    required this.modelName,
    required this.cargoTypeName,
    required this.photos,
  });

  final Crossing crossing;
  final String companyName;
  final String makeName;
  final String? modelName;
  final String cargoTypeName;
  final List<CrossingPhoto> photos;

  String get vehicleLabel =>
      modelName == null ? makeName : '$makeName $modelName';
}
