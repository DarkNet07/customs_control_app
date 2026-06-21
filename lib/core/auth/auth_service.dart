import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

/// Handles PIN (hashed) and biometric authentication.
class AuthService {
  AuthService({
    FlutterSecureStorage? storage,
    LocalAuthentication? localAuth,
  })  : _storage = storage ?? const FlutterSecureStorage(),
        _localAuth = localAuth ?? LocalAuthentication();

  final FlutterSecureStorage _storage;
  final LocalAuthentication _localAuth;

  static const _kPinHash = 'pin_hash';
  static const _kPinEnabled = 'pin_enabled';
  static const _kBiometricEnabled = 'biometric_enabled';

  String _hash(String pin) => sha256.convert(utf8.encode(pin)).toString();

  Future<bool> isPinEnabled() async =>
      (await _storage.read(key: _kPinEnabled)) == 'true';

  Future<bool> isBiometricEnabled() async =>
      (await _storage.read(key: _kBiometricEnabled)) == 'true';

  Future<bool> isProtectionEnabled() async =>
      (await isPinEnabled()) || (await isBiometricEnabled());

  Future<void> setPin(String pin) async {
    await _storage.write(key: _kPinHash, value: _hash(pin));
    await _storage.write(key: _kPinEnabled, value: 'true');
  }

  Future<void> disablePin() async {
    await _storage.delete(key: _kPinHash);
    await _storage.write(key: _kPinEnabled, value: 'false');
  }

  Future<bool> verifyPin(String pin) async {
    final stored = await _storage.read(key: _kPinHash);
    return stored != null && stored == _hash(pin);
  }

  Future<bool> canUseBiometrics() async {
    try {
      return await _localAuth.canCheckBiometrics ||
          await _localAuth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  Future<void> setBiometricEnabled(bool enabled) async {
    await _storage.write(
        key: _kBiometricEnabled, value: enabled ? 'true' : 'false');
  }

  Future<bool> authenticateBiometric(String reason) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: reason,
        biometricOnly: false,
        persistAcrossBackgrounding: true,
      );
    } catch (_) {
      return false;
    }
  }
}
