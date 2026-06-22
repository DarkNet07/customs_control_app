// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Контроль таможни';

  @override
  String get navHome => 'Главная';

  @override
  String get navJournal => 'Журнал';

  @override
  String get navCompanies => 'Компании';

  @override
  String get navStatistics => 'Статистика';

  @override
  String get navMore => 'Ещё';

  @override
  String get navDictionaries => 'Справочники';

  @override
  String get navExport => 'Экспорт';

  @override
  String get navSettings => 'Настройки';

  @override
  String get addCrossing => 'Новая запись';

  @override
  String get editCrossing => 'Редактировать запись';

  @override
  String get company => 'Компания';

  @override
  String get selectCompany => 'Выберите компанию';

  @override
  String get vehicleMake => 'Марка авто';

  @override
  String get vehicleModel => 'Модель';

  @override
  String get cargoType => 'Тип груза';

  @override
  String get plateCountry => 'Страна номера';

  @override
  String get plateNumber => 'Гос. номер';

  @override
  String get plateFormat => 'Формат номера';

  @override
  String get uzbekistan => 'Узбекистан';

  @override
  String get tajikistan => 'Таджикистан';

  @override
  String get cargoQuantity => 'Кол. груза';

  @override
  String get quantityUnit => 'Ед. изм.';

  @override
  String get crossedAt => 'Дата и время';

  @override
  String get note => 'Заметка';

  @override
  String get photos => 'Фото';

  @override
  String get takePhoto => 'Камера';

  @override
  String get pickFromGallery => 'Галерея';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get edit => 'Редактировать';

  @override
  String get add => 'Добавить';

  @override
  String get search => 'Поиск';

  @override
  String get sort => 'Сортировка';

  @override
  String get groupBy => 'Группировка';

  @override
  String get groupByVehicle => 'По авто';

  @override
  String get groupByCargo => 'По типу груза';

  @override
  String get sortByCompany => 'По компании';

  @override
  String get sortByMake => 'По марке';

  @override
  String get sortByPlate => 'По госномеру';

  @override
  String get sortByTime => 'По времени';

  @override
  String get sortByCargo => 'По типу груза';

  @override
  String get ascending => 'По возрастанию';

  @override
  String get descending => 'По убыванию';

  @override
  String get history => 'История изменений';

  @override
  String get deleteWarningTitle => 'Удалить запись?';

  @override
  String get deleteWarningBody =>
      'Это действие нельзя отменить. Запись будет помечена как удалённая и сохранена в истории.';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get addModelTitle => 'Добавить модель';

  @override
  String get addModelHint => 'Введите название модели';

  @override
  String get addMakeTitle => 'Добавить марку';

  @override
  String get addCompanyTitle => 'Добавить компанию';

  @override
  String get addCargoTypeTitle => 'Добавить тип груза';

  @override
  String get fieldRequired => 'Обязательное поле';

  @override
  String get invalidPlate => 'Неверный формат номера';

  @override
  String get noData => 'Нет данных';

  @override
  String get language => 'Язык';

  @override
  String get theme => 'Тема';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get security => 'Безопасность';

  @override
  String get biometricAuth => 'Вход по биометрии';

  @override
  String get pinAuth => 'Вход по PIN-коду';

  @override
  String get setupPin => 'Задать PIN-код';

  @override
  String get enterPin => 'Введите PIN-код';

  @override
  String get confirmPin => 'Повторите PIN-код';

  @override
  String get pinMismatch => 'PIN-коды не совпадают';

  @override
  String get wrongPin => 'Неверный PIN-код';

  @override
  String get unlock => 'Разблокировать';

  @override
  String get useBiometrics => 'Использовать биометрию';

  @override
  String get skip => 'Пропустить';

  @override
  String get next => 'Далее';

  @override
  String get onboardingWelcome => 'Добро пожаловать';

  @override
  String get onboardingSecurityDesc =>
      'Защитите данные входом по биометрии или PIN-коду. Это можно настроить позже в разделе «Настройки».';

  @override
  String get enableProtection => 'Включить защиту';

  @override
  String get totalCrossings => 'Всего записей';

  @override
  String get today => 'Сегодня';

  @override
  String get thisWeek => 'Неделя';

  @override
  String get thisMonth => 'Месяц';

  @override
  String get topCompanies => 'Топ компаний';

  @override
  String get byCargoType => 'По типам груза';

  @override
  String get exportExcel => 'Экспорт в Excel';

  @override
  String get exportPdf => 'Экспорт в PDF';

  @override
  String get exportPeriod => 'Период экспорта';

  @override
  String get exportFrom => 'С';

  @override
  String get exportTo => 'По';

  @override
  String get exportSuccess => 'Файл сформирован';

  @override
  String get companies => 'Компании';

  @override
  String get dictionaries => 'Справочники';

  @override
  String get makesAndModels => 'Марки и модели';

  @override
  String get cargoTypes => 'Типы груза';

  @override
  String get optional => 'необязательно';

  @override
  String get createCrossingFirst => 'Создайте первую запись';

  @override
  String get serverMode => 'Режим сервера (API)';

  @override
  String get apiUrl => 'Адрес сервера';

  @override
  String get localMode => 'Локальное хранилище';

  @override
  String get changedAt => 'Изменено';

  @override
  String get changeCreate => 'Создание';

  @override
  String get changeUpdate => 'Изменение';

  @override
  String get changeDelete => 'Удаление';

  @override
  String get quantity => 'Кол-во';

  @override
  String get location => 'Местоположение';

  @override
  String get captureLocation => 'Определить местоположение';

  @override
  String get locationUnavailable => 'Местоположение не определено';

  @override
  String get coordinates => 'Координаты';

  @override
  String get openInMaps => 'Открыть в картах';

  @override
  String get clear => 'Очистить';

  @override
  String get noPlateToggle => 'Нет гос. номера';

  @override
  String get noPlateNumber => 'Без номера';

  @override
  String get addCargo => 'Добавить груз';

  @override
  String get cargoList => 'Грузы';

  @override
  String get openSettings => 'Настройки';
}
