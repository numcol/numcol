// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'translations.dart';
import '../domain/index.dart';

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  final Locale newLocale;

  const TranslationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) =>
      LocaleHelper.getAllLanguageCodes().contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) {
    return Translations.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) {
    return true;
  }
}
