import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const List<Locale> supportedLocales = [Locale('en'), Locale('ru')];

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations? _current;

  static AppLocalizations get current =>
      _current ?? AppLocalizations(const Locale('en'));

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        current;
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appName': 'Sneakers Store',
      'errorTitle': 'Error',
      'ok': 'OK',
      'tapToFindModel': 'Tap to find model',
      'scan': 'Scan',
      'sizesInStock': 'Sizes in stock:',
      'sizeLabel': 'Size {size}',
      'inStockLabel': 'In stock: {stock}',
      'resultLabel': 'Result: {result}',
      'pointToBarcode': 'Point to barcode',
      'cameraPermissionDenied':
          'Camera permission denied. Please grant permission in phone settings.',
      'backendConfigMissing':
          'Backend server IP or port is not set on the client. Check the documentation: https://github.com/antonzyryanov/Barcode-Scanner/blob/main/README.md',
      'invalidScannedFormat': 'Invalid scanned string format',
      'itemNotFound': 'Item not found',
      'serverError': 'Server error: {statusCode}',
      'failedRetrieveGoods': 'Failed to retrieve goods: {error}',
      'itemNotFoundInShop': 'Item not found in shop',
    },
    'ru': {
      'appName': 'Магазин кроссовок',
      'errorTitle': 'Ошибка',
      'ok': 'ОК',
      'tapToFindModel': 'Нажмите, чтобы найти модель',
      'scan': 'Сканировать',
      'sizesInStock': 'Размеры в наличии:',
      'sizeLabel': 'Размер {size}',
      'inStockLabel': 'В наличии: {stock}',
      'resultLabel': 'Результат: {result}',
      'pointToBarcode': 'Наведите на штрих-код',
      'cameraPermissionDenied':
          'Доступ к камере запрещен. Разрешите доступ в настройках телефона.',
      'backendConfigMissing':
          'На клиенте не указан IP адрес либо порт Backend сервера. Обратитесь к документации: https://github.com/antonzyryanov/Barcode-Scanner/blob/main/README.md',
      'invalidScannedFormat': 'Неверный формат отсканированной строки',
      'itemNotFound': 'Товар не найден',
      'serverError': 'Ошибка сервера: {statusCode}',
      'failedRetrieveGoods': 'Не удалось получить данные: {error}',
      'itemNotFoundInShop': 'Товар не найден в магазине',
    },
  };

  String _value(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']![key]!;
  }

  String _format(String key, Map<String, String> params) {
    var result = _value(key);
    params.forEach((paramKey, paramValue) {
      result = result.replaceAll('{$paramKey}', paramValue);
    });
    return result;
  }

  String get appName => _value('appName');
  String get errorTitle => _value('errorTitle');
  String get ok => _value('ok');
  String get tapToFindModel => _value('tapToFindModel');
  String get scan => _value('scan');
  String get sizesInStock => _value('sizesInStock');
  String get pointToBarcode => _value('pointToBarcode');
  String get cameraPermissionDenied => _value('cameraPermissionDenied');
  String get backendConfigMissing => _value('backendConfigMissing');
  String get invalidScannedFormat => _value('invalidScannedFormat');
  String get itemNotFound => _value('itemNotFound');
  String get itemNotFoundInShop => _value('itemNotFoundInShop');

  String sizeLabel(String size) => _format('sizeLabel', {'size': size});

  String inStockLabel(int stock) =>
      _format('inStockLabel', {'stock': stock.toString()});

  String resultLabel(String result) =>
      _format('resultLabel', {'result': result});

  String serverError(int statusCode) =>
      _format('serverError', {'statusCode': statusCode.toString()});

  String failedRetrieveGoods(Object error) =>
      _format('failedRetrieveGoods', {'error': error.toString()});
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.any(
      (supported) => supported.languageCode == locale.languageCode,
    );
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localization = AppLocalizations(locale);
    AppLocalizations._current = localization;
    return localization;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
