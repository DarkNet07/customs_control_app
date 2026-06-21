import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/auth/lock_controller.dart';
import 'core/l10n/l10n.dart';
import 'core/l10n/material_fallback.dart';
import 'core/providers.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/app_gate.dart';

class CustomsApp extends ConsumerStatefulWidget {
  const CustomsApp({super.key});

  @override
  ConsumerState<CustomsApp> createState() => _CustomsAppState();
}

class _CustomsAppState extends ConsumerState<CustomsApp>
    with WidgetsBindingObserver {
  late final _router = buildRouter();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Re-lock when the app is sent to the background.
    if (state == AppLifecycleState.paused) {
      ref.read(lockProvider.notifier).relock();
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: settings.themeMode,
      locale: settings.locale,
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        // Fallback Tajik delegates serve Russian system strings for Material/
        // Cupertino widgets, which Flutter doesn't ship for `tg`.
        TgMaterialLocalizationsDelegate(),
        TgCupertinoLocalizationsDelegate(),
        TgWidgetsLocalizationsDelegate(),
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
      builder: (context, child) => AppGate(child: child ?? const SizedBox()),
    );
  }
}
