import 'package:customs_control_app/core/plate/plate_formats.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Uzbekistan standard (01 A 123 BC)', () {
    final f = PlateFormats.byKey('uz_standard');
    test('accepts valid plates', () {
      expect(f.isValid('01 A 123 BC'), isTrue);
      expect(f.isValid('01A123BC'), isTrue);
      expect(f.isValid('90 z 999 ab'), isTrue);
    });
    test('rejects invalid plates', () {
      expect(f.isValid('1 A 123 BC'), isFalse);
      expect(f.isValid('01 12 123 BC'), isFalse);
      expect(f.isValid('01 A 12 BC'), isFalse);
    });
  });

  group('Uzbekistan alt (01 123 ABC)', () {
    final f = PlateFormats.byKey('uz_alt');
    test('accepts valid plates', () {
      expect(f.isValid('01 123 ABC'), isTrue);
      expect(f.isValid('01123ABC'), isTrue);
    });
    test('rejects invalid plates', () {
      expect(f.isValid('01 123 AB'), isFalse);
      expect(f.isValid('01 12 ABC'), isFalse);
    });
  });

  group('Tajikistan standard (1234 AB 01)', () {
    final f = PlateFormats.byKey('tj_standard');
    test('accepts valid plates', () {
      expect(f.isValid('1234 AB 01'), isTrue);
      expect(f.isValid('1234AB01'), isTrue);
    });
    test('rejects invalid plates', () {
      expect(f.isValid('123 AB 01'), isFalse);
      expect(f.isValid('1234 A 01'), isFalse);
    });
  });

  test('forCountry returns only matching formats', () {
    expect(PlateFormats.forCountry('uz').length, 2);
    expect(PlateFormats.forCountry('tj').length, 1);
    expect(PlateFormats.forCountry('uz').every((f) => f.country == 'uz'),
        isTrue);
  });
}
