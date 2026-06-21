import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import 'auth_service.dart';

/// Whether the app is currently locked behind PIN/biometrics.
final lockProvider =
    NotifierProvider<LockController, LockState>(LockController.new);

class LockState {
  const LockState({required this.locked, required this.checked});
  final bool locked;
  final bool checked; // protection status resolved at least once
}

class LockController extends Notifier<LockState> {
  @override
  LockState build() {
    _init();
    return const LockState(locked: false, checked: false);
  }

  AuthService get _auth => ref.read(authServiceProvider);

  Future<void> _init() async {
    final enabled = await _auth.isProtectionEnabled();
    state = LockState(locked: enabled, checked: true);
  }

  /// Call when returning from background to re-lock if protection is on.
  Future<void> relock() async {
    if (await _auth.isProtectionEnabled()) {
      state = const LockState(locked: true, checked: true);
    }
  }

  void unlock() => state = const LockState(locked: false, checked: true);
}
