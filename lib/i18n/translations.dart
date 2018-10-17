// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show  rootBundle;

import 'locales.dart';

class Translations {
  Translations(Locale locale) {
    this.locale = locale;
    _localizedValues = null;
  }

  Locale locale;
  static Map<dynamic, dynamic> _localizedValues = new Map<dynamic, dynamic>();

  static Translations of(BuildContext context){
    return Localizations.of<Translations>(context, Translations);
  }

  String text(String key) => _localizedValues != null && _localizedValues[key] != null ? _localizedValues[key] : '';

  static Future<Translations> load(Locale locale) async {
    Translations translations = new Translations(locale);
    String jsonContent = await rootBundle.loadString("locale/i18n_${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  get currentLanguage => locale.languageCode;

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

  static final List<String> supportedLanguages = getAllLanguageCodes();

  static Iterable<Locale> supportedLocales() => supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));
}
