import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/auth/lock_controller.dart';
import '../../core/l10n/l10n.dart';
import '../../core/providers.dart';
import '../../core/widgets/brand_logo.dart';

class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  final _pin = TextEditingController();
  String? _error;
  bool _biometricEnabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryBiometric());
  }

  @override
  void dispose() {
    _pin.dispose();
    super.dispose();
  }

  Future<void> _tryBiometric() async {
    final auth = ref.read(authServiceProvider);
    final reason = context.l10n.unlock;
    final enabled = await auth.isBiometricEnabled();
    setState(() => _biometricEnabled = enabled);
    if (!enabled) return;
    final ok = await auth.authenticateBiometric(reason);
    if (ok) ref.read(lockProvider.notifier).unlock();
  }

  Future<void> _submitPin() async {
    final auth = ref.read(authServiceProvider);
    if (await auth.verifyPin(_pin.text)) {
      ref.read(lockProvider.notifier).unlock();
    } else {
      setState(() => _error = context.l10n.wrongPin);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: BrandLogo(size: 96)),
              const SizedBox(height: 24),
              Text(l10n.appTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 32),
              TextField(
                controller: _pin,
                obscureText: true,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 8,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: l10n.enterPin,
                  errorText: _error,
                ),
                onSubmitted: (_) => _submitPin(),
              ),
              const SizedBox(height: 16),
              FilledButton(onPressed: _submitPin, child: Text(l10n.unlock)),
              if (_biometricEnabled) ...[
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  icon: const Icon(Icons.fingerprint),
                  label: Text(l10n.useBiometrics),
                  onPressed: _tryBiometric,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
