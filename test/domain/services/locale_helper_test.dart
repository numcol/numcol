// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:test/test.dart';

import '../../../lib/domain/index.dart';

void main() {
  group('Locale Helper:', () {
    group('When getting locales', () {
      test('it returs all available locales', () {
        var locales = LocaleHelper.getLocales();
        expect(locales.length, 6);
        expect(locales.contains(Locales.english), true);
        expect(locales.contains(Locales.castellano), true);
        expect(locales.contains(Locales.catala), true);
        expect(locales.contains(Locales.galego), true);
        expect(locales.contains(Locales.euskara), true);
        expect(locales.contains(Locales.francais), true);
      });
    });

    group('When getting locale code by locale', () {
      test('it returs the proper language code', () {
        expect(LocaleHelper.getLanguageCode(Locales.english), 'en');
        expect(LocaleHelper.getLanguageCode(Locales.castellano), 'es');
        expect(LocaleHelper.getLanguageCode(Locales.catala), 'ca');
        expect(LocaleHelper.getLanguageCode(Locales.galego), 'gl');
        expect(LocaleHelper.getLanguageCode(Locales.euskara), 'eu');
        expect(LocaleHelper.getLanguageCode(Locales.francais), 'fr');
      });
    });

    group('When getting all language codes', () {
      test('it returs all available language codes', () {
        var locales = LocaleHelper.getAllLanguageCodes();
        expect(locales.length, 6);
        expect(locales.contains('en'), true);
        expect(locales.contains('es'), true);
        expect(locales.contains('ca'), true);
        expect(locales.contains('gl'), true);
        expect(locales.contains('eu'), true);
        expect(locales.contains('fr'), true);
      });
    });

    group('When getting locale text by locale', () {
      test('it returs the proper language text', () {
        expect(LocaleHelper.getLanguageText(Locales.english), 'English');
        expect(LocaleHelper.getLanguageText(Locales.castellano), 'Español');
        expect(LocaleHelper.getLanguageText(Locales.catala), 'Català');
        expect(LocaleHelper.getLanguageText(Locales.galego), 'Galego');
        expect(LocaleHelper.getLanguageText(Locales.euskara), 'Euskara');
        expect(LocaleHelper.getLanguageText(Locales.francais), 'Français');
      });
    });

    group('When getting locale by language code', () {
      test('it returs the proper locale', () {
        expect(LocaleHelper.getLocaleByLanguageCode('en'), Locales.english);
        expect(LocaleHelper.getLocaleByLanguageCode('es'), Locales.castellano);
        expect(LocaleHelper.getLocaleByLanguageCode('ca'), Locales.catala);
        expect(LocaleHelper.getLocaleByLanguageCode('gl'), Locales.galego);
        expect(LocaleHelper.getLocaleByLanguageCode('eu'), Locales.euskara);
        expect(LocaleHelper.getLocaleByLanguageCode('fr'), Locales.francais);
      });
    });
  });
}
