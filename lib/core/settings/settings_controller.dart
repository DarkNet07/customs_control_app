import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  const AppSettings({
    this.locale = const Locale('ru'),
    this.themeMode = ThemeMode.system,
    this.onboardingDone = false,
    this.serverMode = false,
    this.apiUrl = '',
  });

  final Locale locale;
  final ThemeMode themeMode;
  final bool onboardingDone;
  final bool serverMode;
  final String apiUrl;

  AppSettings copyWith({
    Locale? locale,
    ThemeMode? themeMode,
    bool? onboardingDone,
    bool? serverMode,
    String? apiUrl,
  }) {
    return AppSettings(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      onboardingDone: onboardingDone ?? this.onboardingDone,
      serverMode: serverMode ?? this.serverMode,
      apiUrl: apiUrl ?? this.apiUrl,
    );
  }
}

/// Injected in [main] with the resolved [SharedPreferences] instance.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('Override in main()'),
);

final settingsProvider =
    NotifierProvider<SettingsController, AppSettings>(SettingsController.new);

class SettingsController extends Notifier<AppSettings> {
  static const _kLocale = 'locale';
  static const _kTheme = 'theme_mode';
  static const _kOnboarding = 'onboarding_done';
  static const _kServerMode = 'server_mode';
  static const _kApiUrl = 'api_url';

  late final SharedPreferences _prefs;

  @override
  AppSettings build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    return AppSettings(
      locale: Locale(_prefs.getString(_kLocale) ?? 'ru'),
      themeMode: ThemeMode.values[_prefs.getInt(_kTheme) ?? 0],
      onboardingDone: _prefs.getBool(_kOnboarding) ?? false,
      serverMode: _prefs.getBool(_kServerMode) ?? false,
      apiUrl: _prefs.getString(_kApiUrl) ?? '',
    );
  }

  Future<void> setLocale(Locale locale) async {
    await _prefs.setString(_kLocale, locale.languageCode);
    state = state.copyWith(locale: locale);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setInt(_kTheme, mode.index);
    state = state.copyWith(themeMode: mode);
  }

  Future<void> completeOnboarding() async {
    await _prefs.setBool(_kOnboarding, true);
    state = state.copyWith(onboardingDone: true);
  }

  Future<void> setServerMode(bool enabled) async {
    await _prefs.setBool(_kServerMode, enabled);
    state = state.copyWith(serverMode: enabled);
  }

  Future<void> setApiUrl(String url) async {
    await _prefs.setString(_kApiUrl, url);
    state = state.copyWith(apiUrl: url);
  }
}
