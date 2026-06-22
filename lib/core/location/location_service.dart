import 'package:geolocator/geolocator.dart';

typedef GeoPoint = ({double lat, double lng});

enum LocationStatus { ok, deniedForever, serviceDisabled, unavailable }

/// Result of a location attempt: a point (if any) plus the reason when absent,
/// so the UI can offer to open settings.
class LocationResult {
  const LocationResult(this.status, [this.point]);
  final LocationStatus status;
  final GeoPoint? point;
}

/// Best-effort current location. Location is always optional for a record.
class LocationService {
  Future<LocationResult> current() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return const LocationResult(LocationStatus.serviceDisabled);
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        return const LocationResult(LocationStatus.deniedForever);
      }
      if (permission == LocationPermission.denied) {
        return const LocationResult(LocationStatus.unavailable);
      }

      Position? pos;
      try {
        pos = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            timeLimit: Duration(seconds: 15),
          ),
        );
      } catch (_) {
        // No fix in time — fall back to the last known position.
        pos = await Geolocator.getLastKnownPosition();
      }
      if (pos == null) return const LocationResult(LocationStatus.unavailable);
      return LocationResult(
        LocationStatus.ok,
        (lat: pos.latitude, lng: pos.longitude),
      );
    } catch (_) {
      return const LocationResult(LocationStatus.unavailable);
    }
  }

  /// Opens the app's settings page (to grant a permanently denied permission).
  Future<void> openAppSettings() => Geolocator.openAppSettings();

  /// Opens the device location settings (to turn the service on).
  Future<void> openLocationSettings() => Geolocator.openLocationSettings();
}
