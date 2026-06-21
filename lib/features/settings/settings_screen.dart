import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/l10n.dart';
import '../../core/providers.dart';
import '../../core/widgets/text_input_dialog.dart';
import '../auth/pin_dialog.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _pinEnabled = false;
  bool _biometricEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSecurity();
  }

  Future<void> _loadSecurity() async {
    final auth = ref.read(authServiceProvider);
    final pin = await auth.isPinEnabled();
    final bio = await auth.isBiometricEnabled();
    if (mounted) {
      setState(() {
        _pinEnabled = pin;
        _biometricEnabled = bio;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);
    final controller = ref.read(settingsProvider.notifier);
    final auth = ref.read(authServiceProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSettings)),
      body: ListView(
        children: [
          _sectionHeader(context, l10n.language),
          RadioGroup<String>(
            groupValue: settings.locale.languageCode,
            onChanged: (v) =>
                v == null ? null : controller.setLocale(Locale(v)),
            child: const Column(
              children: [
                RadioListTile<String>(
                    value: 'ru', title: Text('Русский')),
                RadioListTile<String>(
                    value: 'tg', title: Text('Тоҷикӣ')),
              ],
            ),
          ),
          const Divider(),
          _sectionHeader(context, l10n.theme),
          RadioGroup<ThemeMode>(
            groupValue: settings.themeMode,
            onChanged: (v) => v == null ? null : controller.setThemeMode(v),
            child: Column(
              children: [
                RadioListTile<ThemeMode>(
                    value: ThemeMode.system, title: Text(l10n.themeSystem)),
                RadioListTile<ThemeMode>(
                    value: ThemeMode.light, title: Text(l10n.themeLight)),
                RadioListTile<ThemeMode>(
                    value: ThemeMode.dark, title: Text(l10n.themeDark)),
              ],
            ),
          ),
          const Divider(),
          _sectionHeader(context, l10n.security),
          SwitchListTile(
            title: Text(l10n.pinAuth),
            value: _pinEnabled,
            onChanged: (v) async {
              if (v) {
                final pin = await showPinSetupDialog(context);
                if (pin == null) return;
                await auth.setPin(pin);
              } else {
                await auth.disablePin();
              }
              await _loadSecurity();
            },
          ),
          SwitchListTile(
            title: Text(l10n.biometricAuth),
            value: _biometricEnabled,
            onChanged: (v) async {
              if (v && !await auth.canUseBiometrics()) return;
              await auth.setBiometricEnabled(v);
              await _loadSecurity();
            },
          ),
          const Divider(),
          _sectionHeader(context, l10n.serverMode),
          SwitchListTile(
            title: Text(l10n.serverMode),
            subtitle: Text(settings.serverMode ? l10n.serverMode : l10n.localMode),
            value: settings.serverMode,
            onChanged: controller.setServerMode,
          ),
          ListTile(
            title: Text(l10n.apiUrl),
            subtitle: Text(settings.apiUrl.isEmpty ? '—' : settings.apiUrl),
            trailing: const Icon(Icons.edit_outlined),
            onTap: () async {
              final url = await showTextInputDialog(context,
                  title: l10n.apiUrl, initial: settings.apiUrl);
              if (url != null) await controller.setApiUrl(url);
            },
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
