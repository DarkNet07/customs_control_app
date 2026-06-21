import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Small rounded country flag. [code] is one of: 'ru', 'uz', 'tj'.
class FlagIcon extends StatelessWidget {
  const FlagIcon(this.code, {super.key, this.width = 28});

  final String code;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: SvgPicture.asset(
        'assets/flags/$code.svg',
        width: width,
        height: width * 0.7, // flags are 4:3-ish
        fit: BoxFit.cover,
      ),
    );
  }
}
