// Rasterizes the branding SVGs into PNGs using Flutter's own engine.
//
// Run with:  flutter test tool/generate_icons.dart
//
// This avoids depending on external SVG converters (rsvg/inkscape/imagemagick),
// none of which are available in this environment. The produced PNGs feed
// `flutter_launcher_icons` and serve as fallbacks for the in-app logo.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> render(String svgPath, String pngPath, int size) async {
  final svg = await File(svgPath).readAsString();
  final info = await vg.loadPicture(SvgStringLoader(svg), null);
  final image = await info.picture.toImage(size, size);
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  await File(pngPath).writeAsBytes(bytes!.buffer.asUint8List());
  info.picture.dispose();
  image.dispose();
  stdout.writeln('wrote $pngPath (${size}x$size)');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('generate adaptive foreground PNG', () async {
    // app_icon.png is produced by padding the provided artwork (see README);
    // here we only rasterize the transparent adaptive foreground.
    const dir = 'assets/branding';
    await render(
        '$dir/app_icon_foreground.svg', '$dir/app_icon_foreground.png', 1024);
    expect(File('$dir/app_icon_foreground.png').existsSync(), isTrue);
    // Sanity: PNG magic header.
    final header =
        await File('$dir/app_icon_foreground.png').openRead(0, 8).first;
    expect(header.sublist(0, 4), <int>[0x89, 0x50, 0x4E, 0x47]);
  });
}
