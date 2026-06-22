import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ru.dart';
import 'app_localizations_tg.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ru'),
    Locale('tg'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In ru, this message translates to:
  /// **'Контроль таможни'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In ru, this message translates to:
  /// **'Главная'**
  String get navHome;

  /// No description provided for @navJournal.
  ///
  /// In ru, this message translates to:
  /// **'Журнал'**
  String get navJournal;

  /// No description provided for @navCompanies.
  ///
  /// In ru, this message translates to:
  /// **'Компании'**
  String get navCompanies;

  /// No description provided for @navStatistics.
  ///
  /// In ru, this message translates to:
  /// **'Статистика'**
  String get navStatistics;

  /// No description provided for @navMore.
  ///
  /// In ru, this message translates to:
  /// **'Ещё'**
  String get navMore;

  /// No description provided for @navDictionaries.
  ///
  /// In ru, this message translates to:
  /// **'Справочники'**
  String get navDictionaries;

  /// No description provided for @navExport.
  ///
  /// In ru, this message translates to:
  /// **'Экспорт'**
  String get navExport;

  /// No description provided for @navSettings.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get navSettings;

  /// No description provided for @addCrossing.
  ///
  /// In ru, this message translates to:
  /// **'Новая запись'**
  String get addCrossing;

  /// No description provided for @editCrossing.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать запись'**
  String get editCrossing;

  /// No description provided for @company.
  ///
  /// In ru, this message translates to:
  /// **'Компания'**
  String get company;

  /// No description provided for @selectCompany.
  ///
  /// In ru, this message translates to:
  /// **'Выберите компанию'**
  String get selectCompany;

  /// No description provided for @vehicleMake.
  ///
  /// In ru, this message translates to:
  /// **'Марка авто'**
  String get vehicleMake;

  /// No description provided for @vehicleModel.
  ///
  /// In ru, this message translates to:
  /// **'Модель'**
  String get vehicleModel;

  /// No description provided for @cargoType.
  ///
  /// In ru, this message translates to:
  /// **'Тип груза'**
  String get cargoType;

  /// No description provided for @plateCountry.
  ///
  /// In ru, this message translates to:
  /// **'Страна номера'**
  String get plateCountry;

  /// No description provided for @plateNumber.
  ///
  /// In ru, this message translates to:
  /// **'Гос. номер'**
  String get plateNumber;

  /// No description provided for @plateFormat.
  ///
  /// In ru, this message translates to:
  /// **'Формат номера'**
  String get plateFormat;

  /// No description provided for @uzbekistan.
  ///
  /// In ru, this message translates to:
  /// **'Узбекистан'**
  String get uzbekistan;

  /// No description provided for @tajikistan.
  ///
  /// In ru, this message translates to:
  /// **'Таджикистан'**
  String get tajikistan;

  /// No description provided for @cargoQuantity.
  ///
  /// In ru, this message translates to:
  /// **'Кол. груза'**
  String get cargoQuantity;

  /// No description provided for @quantityUnit.
  ///
  /// In ru, this message translates to:
  /// **'Ед. изм.'**
  String get quantityUnit;

  /// No description provided for @crossedAt.
  ///
  /// In ru, this message translates to:
  /// **'Дата и время'**
  String get crossedAt;

  /// No description provided for @note.
  ///
  /// In ru, this message translates to:
  /// **'Заметка'**
  String get note;

  /// No description provided for @photos.
  ///
  /// In ru, this message translates to:
  /// **'Фото'**
  String get photos;

  /// No description provided for @takePhoto.
  ///
  /// In ru, this message translates to:
  /// **'Камера'**
  String get takePhoto;

  /// No description provided for @pickFromGallery.
  ///
  /// In ru, this message translates to:
  /// **'Галерея'**
  String get pickFromGallery;

  /// No description provided for @save.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In ru, this message translates to:
  /// **'Добавить'**
  String get add;

  /// No description provided for @search.
  ///
  /// In ru, this message translates to:
  /// **'Поиск'**
  String get search;

  /// No description provided for @sort.
  ///
  /// In ru, this message translates to:
  /// **'Сортировка'**
  String get sort;

  /// No description provided for @groupBy.
  ///
  /// In ru, this message translates to:
  /// **'Группировка'**
  String get groupBy;

  /// No description provided for @groupByVehicle.
  ///
  /// In ru, this message translates to:
  /// **'По авто'**
  String get groupByVehicle;

  /// No description provided for @groupByCargo.
  ///
  /// In ru, this message translates to:
  /// **'По типу груза'**
  String get groupByCargo;

  /// No description provided for @sortByCompany.
  ///
  /// In ru, this message translates to:
  /// **'По компании'**
  String get sortByCompany;

  /// No description provided for @sortByMake.
  ///
  /// In ru, this message translates to:
  /// **'По марке'**
  String get sortByMake;

  /// No description provided for @sortByPlate.
  ///
  /// In ru, this message translates to:
  /// **'По госномеру'**
  String get sortByPlate;

  /// No description provided for @sortByTime.
  ///
  /// In ru, this message translates to:
  /// **'По времени'**
  String get sortByTime;

  /// No description provided for @sortByCargo.
  ///
  /// In ru, this message translates to:
  /// **'По типу груза'**
  String get sortByCargo;

  /// No description provided for @ascending.
  ///
  /// In ru, this message translates to:
  /// **'По возрастанию'**
  String get ascending;

  /// No description provided for @descending.
  ///
  /// In ru, this message translates to:
  /// **'По убыванию'**
  String get descending;

  /// No description provided for @history.
  ///
  /// In ru, this message translates to:
  /// **'История изменений'**
  String get history;

  /// No description provided for @deleteWarningTitle.
  ///
  /// In ru, this message translates to:
  /// **'Удалить запись?'**
  String get deleteWarningTitle;

  /// No description provided for @deleteWarningBody.
  ///
  /// In ru, this message translates to:
  /// **'Это действие нельзя отменить. Запись будет помечена как удалённая и сохранена в истории.'**
  String get deleteWarningBody;

  /// No description provided for @confirm.
  ///
  /// In ru, this message translates to:
  /// **'Подтвердить'**
  String get confirm;

  /// No description provided for @addModelTitle.
  ///
  /// In ru, this message translates to:
  /// **'Добавить модель'**
  String get addModelTitle;

  /// No description provided for @addModelHint.
  ///
  /// In ru, this message translates to:
  /// **'Введите название модели'**
  String get addModelHint;

  /// No description provided for @addMakeTitle.
  ///
  /// In ru, this message translates to:
  /// **'Добавить марку'**
  String get addMakeTitle;

  /// No description provided for @addCompanyTitle.
  ///
  /// In ru, this message translates to:
  /// **'Добавить компанию'**
  String get addCompanyTitle;

  /// No description provided for @addCargoTypeTitle.
  ///
  /// In ru, this message translates to:
  /// **'Добавить тип груза'**
  String get addCargoTypeTitle;

  /// No description provided for @fieldRequired.
  ///
  /// In ru, this message translates to:
  /// **'Обязательное поле'**
  String get fieldRequired;

  /// No description provided for @invalidPlate.
  ///
  /// In ru, this message translates to:
  /// **'Неверный формат номера'**
  String get invalidPlate;

  /// No description provided for @noData.
  ///
  /// In ru, this message translates to:
  /// **'Нет данных'**
  String get noData;

  /// No description provided for @language.
  ///
  /// In ru, this message translates to:
  /// **'Язык'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In ru, this message translates to:
  /// **'Тема'**
  String get theme;

  /// No description provided for @themeSystem.
  ///
  /// In ru, this message translates to:
  /// **'Системная'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In ru, this message translates to:
  /// **'Светлая'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In ru, this message translates to:
  /// **'Тёмная'**
  String get themeDark;

  /// No description provided for @security.
  ///
  /// In ru, this message translates to:
  /// **'Безопасность'**
  String get security;

  /// No description provided for @biometricAuth.
  ///
  /// In ru, this message translates to:
  /// **'Вход по биометрии'**
  String get biometricAuth;

  /// No description provided for @pinAuth.
  ///
  /// In ru, this message translates to:
  /// **'Вход по PIN-коду'**
  String get pinAuth;

  /// No description provided for @setupPin.
  ///
  /// In ru, this message translates to:
  /// **'Задать PIN-код'**
  String get setupPin;

  /// No description provided for @enterPin.
  ///
  /// In ru, this message translates to:
  /// **'Введите PIN-код'**
  String get enterPin;

  /// No description provided for @confirmPin.
  ///
  /// In ru, this message translates to:
  /// **'Повторите PIN-код'**
  String get confirmPin;

  /// No description provided for @pinMismatch.
  ///
  /// In ru, this message translates to:
  /// **'PIN-коды не совпадают'**
  String get pinMismatch;

  /// No description provided for @wrongPin.
  ///
  /// In ru, this message translates to:
  /// **'Неверный PIN-код'**
  String get wrongPin;

  /// No description provided for @unlock.
  ///
  /// In ru, this message translates to:
  /// **'Разблокировать'**
  String get unlock;

  /// No description provided for @useBiometrics.
  ///
  /// In ru, this message translates to:
  /// **'Использовать биометрию'**
  String get useBiometrics;

  /// No description provided for @skip.
  ///
  /// In ru, this message translates to:
  /// **'Пропустить'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In ru, this message translates to:
  /// **'Далее'**
  String get next;

  /// No description provided for @onboardingWelcome.
  ///
  /// In ru, this message translates to:
  /// **'Добро пожаловать'**
  String get onboardingWelcome;

  /// No description provided for @onboardingSecurityDesc.
  ///
  /// In ru, this message translates to:
  /// **'Защитите данные входом по биометрии или PIN-коду. Это можно настроить позже в разделе «Настройки».'**
  String get onboardingSecurityDesc;

  /// No description provided for @enableProtection.
  ///
  /// In ru, this message translates to:
  /// **'Включить защиту'**
  String get enableProtection;

  /// No description provided for @totalCrossings.
  ///
  /// In ru, this message translates to:
  /// **'Всего записей'**
  String get totalCrossings;

  /// No description provided for @today.
  ///
  /// In ru, this message translates to:
  /// **'Сегодня'**
  String get today;

  /// No description provided for @thisWeek.
  ///
  /// In ru, this message translates to:
  /// **'Неделя'**
  String get thisWeek;

  /// No description provided for @thisMonth.
  ///
  /// In ru, this message translates to:
  /// **'Месяц'**
  String get thisMonth;

  /// No description provided for @topCompanies.
  ///
  /// In ru, this message translates to:
  /// **'Топ компаний'**
  String get topCompanies;

  /// No description provided for @byCargoType.
  ///
  /// In ru, this message translates to:
  /// **'По типам груза'**
  String get byCargoType;

  /// No description provided for @exportExcel.
  ///
  /// In ru, this message translates to:
  /// **'Экспорт в Excel'**
  String get exportExcel;

  /// No description provided for @exportPdf.
  ///
  /// In ru, this message translates to:
  /// **'Экспорт в PDF'**
  String get exportPdf;

  /// No description provided for @exportPeriod.
  ///
  /// In ru, this message translates to:
  /// **'Период экспорта'**
  String get exportPeriod;

  /// No description provided for @exportFrom.
  ///
  /// In ru, this message translates to:
  /// **'С'**
  String get exportFrom;

  /// No description provided for @exportTo.
  ///
  /// In ru, this message translates to:
  /// **'По'**
  String get exportTo;

  /// No description provided for @exportSuccess.
  ///
  /// In ru, this message translates to:
  /// **'Файл сформирован'**
  String get exportSuccess;

  /// No description provided for @companies.
  ///
  /// In ru, this message translates to:
  /// **'Компании'**
  String get companies;

  /// No description provided for @dictionaries.
  ///
  /// In ru, this message translates to:
  /// **'Справочники'**
  String get dictionaries;

  /// No description provided for @makesAndModels.
  ///
  /// In ru, this message translates to:
  /// **'Марки и модели'**
  String get makesAndModels;

  /// No description provided for @cargoTypes.
  ///
  /// In ru, this message translates to:
  /// **'Типы груза'**
  String get cargoTypes;

  /// No description provided for @optional.
  ///
  /// In ru, this message translates to:
  /// **'необязательно'**
  String get optional;

  /// No description provided for @createCrossingFirst.
  ///
  /// In ru, this message translates to:
  /// **'Создайте первую запись'**
  String get createCrossingFirst;

  /// No description provided for @serverMode.
  ///
  /// In ru, this message translates to:
  /// **'Режим сервера (API)'**
  String get serverMode;

  /// No description provided for @apiUrl.
  ///
  /// In ru, this message translates to:
  /// **'Адрес сервера'**
  String get apiUrl;

  /// No description provided for @localMode.
  ///
  /// In ru, this message translates to:
  /// **'Локальное хранилище'**
  String get localMode;

  /// No description provided for @changedAt.
  ///
  /// In ru, this message translates to:
  /// **'Изменено'**
  String get changedAt;

  /// No description provided for @changeCreate.
  ///
  /// In ru, this message translates to:
  /// **'Создание'**
  String get changeCreate;

  /// No description provided for @changeUpdate.
  ///
  /// In ru, this message translates to:
  /// **'Изменение'**
  String get changeUpdate;

  /// No description provided for @changeDelete.
  ///
  /// In ru, this message translates to:
  /// **'Удаление'**
  String get changeDelete;

  /// No description provided for @quantity.
  ///
  /// In ru, this message translates to:
  /// **'Кол-во'**
  String get quantity;

  /// No description provided for @location.
  ///
  /// In ru, this message translates to:
  /// **'Местоположение'**
  String get location;

  /// No description provided for @captureLocation.
  ///
  /// In ru, this message translates to:
  /// **'Определить местоположение'**
  String get captureLocation;

  /// No description provided for @locationUnavailable.
  ///
  /// In ru, this message translates to:
  /// **'Местоположение не определено'**
  String get locationUnavailable;

  /// No description provided for @coordinates.
  ///
  /// In ru, this message translates to:
  /// **'Координаты'**
  String get coordinates;

  /// No description provided for @openInMaps.
  ///
  /// In ru, this message translates to:
  /// **'Открыть в картах'**
  String get openInMaps;

  /// No description provided for @clear.
  ///
  /// In ru, this message translates to:
  /// **'Очистить'**
  String get clear;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ru', 'tg'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru':
      return AppLocalizationsRu();
    case 'tg':
      return AppLocalizationsTg();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
