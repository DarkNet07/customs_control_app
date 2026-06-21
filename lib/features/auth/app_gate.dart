import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/auth/lock_controller.dart';
import '../../core/providers.dart';
import 'lock_screen.dart';
import 'onboarding_screen.dart';

/// Wraps the router output, showing onboarding or the lock screen when needed.
class AppGate extends ConsumerWidget {
  const AppGate({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    if (!settings.onboardingDone) {
      return const OnboardingScreen();
    }
    final lock = ref.watch(lockProvider);
    if (lock.locked) {
      return const LockScreen();
    }
    return child;
  }
}
