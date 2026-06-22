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

  /// Auto-lock only after the app has been in the background for this long
  /// since the last authorization — not on every app switch.
  static const lockAfter = Duration(minutes: 10);

  // While suspended, background/foreground transitions don't re-lock. Used for
  // in-app flows that legitimately background the app (camera, image picker).
  bool _suspended = false;

  // When the app last went to the background.
  DateTime? _backgroundedAt;

  Future<void> _init() async {
    // Cold start: lock immediately if protection is on.
    final enabled = await _auth.isProtectionEnabled();
    state = LockState(locked: enabled, checked: true);
  }

  /// App went to background — remember when, but don't lock yet.
  void onPaused() {
    if (_suspended) return;
    _backgroundedAt = DateTime.now();
  }

  /// App came back to foreground — lock only if it was backgrounded for longer
  /// than [lockAfter] since the last authorization.
  Future<void> onResumed() async {
    if (_suspended) return;
    final since = _backgroundedAt;
    _backgroundedAt = null;
    if (since == null) return;
    if (DateTime.now().difference(since) < lockAfter) return;
    if (await _auth.isProtectionEnabled()) {
      state = const LockState(locked: true, checked: true);
    }
  }

  /// Suspend auto-relock around an in-app activity that backgrounds the app
  /// (e.g. opening the camera or gallery), so the user isn't kicked to the
  /// lock screen on return.
  void suspendAutoLock() => _suspended = true;

  void resumeAutoLock() => _suspended = false;

  void unlock() {
    _backgroundedAt = null;
    state = const LockState(locked: false, checked: true);
  }
}
