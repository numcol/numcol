// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../domain/index.dart';

class Translations {
  Translations(Locale locale) {
    this.locale = locale;
    _localizedValues = null;
  }

  Locale locale;
  static Map<dynamic, dynamic> _localizedValues = Map<dynamic, dynamic>();

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  String text(String key) =>
      _localizedValues != null && _localizedValues[key] != null
          ? _localizedValues[key]
          : '';

  static Future<Translations> load(Locale locale) async {
    Translations translations = Translations(locale);
    String jsonContent = await rootBundle
        .loadString("assets/locale/i18n_${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  get currentLanguage => locale.languageCode;

  static Iterable<Locale> supportedLocales() =>
      LocaleHelper.getAllLanguageCodes()
          .map<Locale>((lang) => Locale(lang, ''));
}
