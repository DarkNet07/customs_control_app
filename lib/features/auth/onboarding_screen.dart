import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/auth/lock_controller.dart';
import '../../core/l10n/l10n.dart';
import '../../core/providers.dart';
import '../../core/widgets/brand_logo.dart';
import 'pin_dialog.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  Future<void> _finish(WidgetRef ref) async {
    await ref.read(settingsProvider.notifier).completeOnboarding();
    ref.read(lockProvider.notifier).unlock();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final auth = ref.read(authServiceProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Center(child: BrandLogo(size: 120)),
              const SizedBox(height: 24),
              Text(l10n.onboardingWelcome,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 12),
              Text(l10n.onboardingSecurityDesc,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium),
              const Spacer(),
              FilledButton.icon(
                icon: const Icon(Icons.fingerprint),
                label: Text(l10n.biometricAuth),
                onPressed: () async {
                  final can = await auth.canUseBiometrics();
                  if (!context.mounted) return;
                  if (!can) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.biometricAuth)),
                    );
                    return;
                  }
                  await auth.setBiometricEnabled(true);
                  await _finish(ref);
                },
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.pin),
                label: Text(l10n.setupPin),
                onPressed: () async {
                  final pin = await showPinSetupDialog(context);
                  if (pin == null) return;
                  await auth.setPin(pin);
                  await _finish(ref);
                },
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => _finish(ref),
                child: Text(l10n.skip),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
