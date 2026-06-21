import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// A selectable license-plate format with its input mask and validation.
///
/// Masks use `mask_text_input_formatter` tokens:
///   `#` = digit, `A` = uppercase Latin letter (we restrict via filter).
class PlateFormat {
  const PlateFormat({
    required this.key,
    required this.country,
    required this.label,
    required this.mask,
    required this.regex,
  });

  final String key;
  final String country; // 'uz' | 'tj'
  final String label;
  final String mask;
  final RegExp regex;

  MaskTextInputFormatter buildFormatter() {
    return MaskTextInputFormatter(
      mask: mask,
      filter: {
        '#': RegExp(r'[0-9]'),
        'A': RegExp(r'[A-Za-z]'),
      },
      type: MaskAutoCompletionType.lazy,
    );
  }

  bool isValid(String value) => regex.hasMatch(value.trim().toUpperCase());
}

/// Registry of supported plate formats. New countries/patterns can be added here.
class PlateFormats {
  PlateFormats._();

  static final List<PlateFormat> all = [
    // Uzbekistan — modern private format: region + letter + 3 digits + 2 letters.
    PlateFormat(
      key: 'uz_standard',
      country: 'uz',
      label: '01 A 123 BC',
      mask: '## A ### AA',
      regex: RegExp(r'^\d{2}\s?[A-Z]\s?\d{3}\s?[A-Z]{2}$'),
    ),
    // Uzbekistan — alternative: region + 3 digits + 3 letters.
    PlateFormat(
      key: 'uz_alt',
      country: 'uz',
      label: '01 123 ABC',
      mask: '## ### AAA',
      regex: RegExp(r'^\d{2}\s?\d{3}\s?[A-Z]{3}$'),
    ),
    // Tajikistan — 4 digits + 2 letters + region.
    PlateFormat(
      key: 'tj_standard',
      country: 'tj',
      label: '1234 AB 01',
      mask: '#### AA ##',
      regex: RegExp(r'^\d{4}\s?[A-Z]{2}\s?\d{2}$'),
    ),
  ];

  static List<PlateFormat> forCountry(String country) =>
      all.where((f) => f.country == country).toList();

  static PlateFormat byKey(String key) =>
      all.firstWhere((f) => f.key == key, orElse: () => all.first);

  static const countries = ['uz', 'tj'];
}
