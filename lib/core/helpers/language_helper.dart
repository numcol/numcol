enum Locales {
  english, castellano, catala, euskara, galego, francais
}

class LanguageHelper {
  static final _codes = {
    Locales.english: 'en',
    Locales.castellano: 'es',
    Locales.francais: 'fr',
    Locales.euskara: 'eu',
    Locales.galego: 'gl',
    Locales.catala: 'ca',
  };

  static final _texts = {
    Locales.english: 'English',
    Locales.castellano: 'Español',
    Locales.francais: 'Français',
    Locales.euskara: 'Euskara',
    Locales.galego: 'Galego',
    Locales.catala: 'Català',
  };

  static List<Locales> getLocales() {
    return _codes.keys.toList();
  }

  static String getLanguageCode(Locales locale) {
    return _codes[locale];
  }

  static List<String> getAllLanguageCodes() {
    return _codes.values.toList();
  }

  static String getLanguageText(Locales locale) {
    return _texts[locale];
  }

  static List<String> getAllLanguageTexts() {
    return _codes.values.toList();
  }

  static Locales getLocaleByLanguageCode(String code) {
    return _codes.keys.firstWhere(
      (k) => _codes[k] == code,
      orElse: () => null,
    );
  }
}
