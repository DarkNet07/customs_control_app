import 'package:flutter/material.dart';

import '../../../core/widgets/flag_icon.dart';

/// Plate number shown together with its country flag.
/// UZ shows the flag on the right, TJ on the left (как на реальных номерах).
class PlateLabel extends StatelessWidget {
  const PlateLabel({
    super.key,
    required this.plateNumber,
    required this.country,
    this.style,
    this.flagWidth = 26,
  });

  final String plateNumber;
  final String country; // 'uz' | 'tj'
  final TextStyle? style;
  final double flagWidth;

  @override
  Widget build(BuildContext context) {
    final flag = FlagIcon(country, width: flagWidth);
    final text = Flexible(
      child: Text(
        plateNumber,
        overflow: TextOverflow.ellipsis,
        style:
            style ??
            const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
      ),
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: country == 'tj'
          ? [flag, const SizedBox(width: 6), text]
          : [text, const SizedBox(width: 6), flag],
    );
  }
}
