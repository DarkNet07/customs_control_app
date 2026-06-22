import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// Non-interactive OpenStreetMap preview with a marker at the given point.
/// Wrap it in a tap handler to open an external maps app.
class LocationMap extends StatelessWidget {
  const LocationMap({
    super.key,
    required this.lat,
    required this.lng,
    this.height = 180,
  });

  final double lat;
  final double lng;
  final double height;

  @override
  Widget build(BuildContext context) {
    final point = LatLng(lat, lng);
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: IgnorePointer(
          child: FlutterMap(
            options: MapOptions(
              initialCenter: point,
              initialZoom: 15,
              interactionOptions:
                  const InteractionOptions(flags: InteractiveFlag.none),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'tj.customs.customs_control_app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: point,
                    width: 44,
                    height: 44,
                    alignment: Alignment.topCenter,
                    child: Icon(
                      Icons.location_on,
                      size: 44,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
