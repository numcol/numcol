// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../collections/index.dart';

class LocaleHelper {
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

  static Locales getLocaleByLanguageCode(String code) {
    return _codes.keys.firstWhere(
      (k) => _codes[k] == code,
      orElse: () => null,
    );
  }
}
