import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The app's themed customs-control logo (yellow badge with officer + arrow).
class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.size = 96});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/branding/logo.svg',
      width: size,
      height: size,
      semanticsLabel: 'Customs Control',
    );
  }
}
