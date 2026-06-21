import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Flutter's bundled GlobalMaterialLocalizations/GlobalCupertinoLocalizations do
// not include Tajik (tg). These fallback delegates claim support for `tg` and
// serve the Russian (ru) system strings instead, so Material/Cupertino widgets
// (date pickers, tooltips, etc.) render correctly while the app's own strings
// stay Tajik. Add them to `localizationsDelegates` after the global delegates.

const _fallback = Locale('ru');

class TgMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const TgMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'tg';

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      GlobalMaterialLocalizations.delegate.load(_fallback);

  @override
  bool shouldReload(TgMaterialLocalizationsDelegate old) => false;
}

class TgCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const TgCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'tg';

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      GlobalCupertinoLocalizations.delegate.load(_fallback);

  @override
  bool shouldReload(TgCupertinoLocalizationsDelegate old) => false;
}

class TgWidgetsLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const TgWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'tg';

  @override
  Future<WidgetsLocalizations> load(Locale locale) =>
      GlobalWidgetsLocalizations.delegate.load(_fallback);

  @override
  bool shouldReload(TgWidgetsLocalizationsDelegate old) => false;
}
