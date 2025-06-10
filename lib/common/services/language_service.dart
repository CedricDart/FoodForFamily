import 'package:flutter/cupertino.dart';

class LanguageChangeProvider with ChangeNotifier {
  Locale _currentLocale = dutch;

  Locale get currentLocale => _currentLocale;

  void changeLocale(String _locale) async {
    _currentLocale = Locale(_locale);

    notifyListeners();
  }
}

Locale french = const Locale('fr');
Locale dutch = const Locale('nl');

enum AppLanguages { nl, en }

class AppLanguagesMap {
  static final Map<AppLanguages, String> _map = {
    AppLanguages.nl: 'NL',
    AppLanguages.en: 'EN',
  };

  static String getLanguageName(AppLanguages language) {
    return _map[language]!;
  }
}
