// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../../../../services/index.dart';
import '../../../../i18n/index.dart';

abstract class LanguageSwitcherViewContract {
  void onLoadChosenLanguageComplete(Locales chosenLocale);
  void onLanguageSaved(Locales chosenLocale);
  void onLanguageSavedError();
}

class LanguageSwitcherPresenter {
  LanguageSwitcherPresenter(this._view, this._storage);

  final LanguageSwitcherViewContract _view;
  final Storage _storage;

  void loadChosenLanguage() {
    _storage.getLanguage()
      .then((languageCode) {
        if (languageCode != null) {
          var locale = TranslationsHelper.getLocaleByLanguageCode(languageCode);
          this._view.onLoadChosenLanguageComplete(locale);
        }
      });
  }

  void onLanguagePressed(Locales locale) {
    var languageCode = TranslationsHelper.getLanguageCode(locale);

    _storage.setLanguage(languageCode)
      .then((isSaved) {
        if (isSaved) {
          this._view.onLanguageSaved(locale);
        } else {
          this._view.onLanguageSavedError();
        }
      });
  }
}
