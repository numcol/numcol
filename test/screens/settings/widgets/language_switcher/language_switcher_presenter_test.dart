// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../lib/i18n/index.dart';
import '../../../../../lib/services/index.dart';
import '../../../../../lib/screens/settings/widgets/language_switcher/language_switcher_presenter.dart';

class MockLanguageSwitcherView extends Mock implements LanguageSwitcherViewContract {}
class MockStorage extends Mock implements Storage {}

void main() {
  MockStorage _mockStorage;
  MockLanguageSwitcherView _mockLanguageSwitcherView;
  LanguageSwitcherPresenter _languageSwitcherPresenter;

  setUp(() async {
    _mockLanguageSwitcherView = MockLanguageSwitcherView();
    _mockStorage = MockStorage();
    _languageSwitcherPresenter = LanguageSwitcherPresenter(_mockLanguageSwitcherView, _mockStorage);
  });

  group('loadChosenLanguage', () {
    test('Should not call callback if language is null', () {
      String value;
      final future = new Future.value(value);
      when(_mockStorage.getLanguage())
        .thenAnswer((_) => future);

      _languageSwitcherPresenter.loadChosenLanguage();

      future.then((_) {
        verifyNever(_mockLanguageSwitcherView.onLoadChosenLanguageComplete(any));
      });
    });

    test('Should call complete callback with proper locale', () {
      final future = new Future.value('eu');
      when(_mockStorage.getLanguage())
        .thenAnswer((_) => future);

      _languageSwitcherPresenter.loadChosenLanguage();

      future.then((_) {
        verify(_mockLanguageSwitcherView.onLoadChosenLanguageComplete(Locales.euskara));
      });
    });
  });

  group('onLanguageClicked', () {
    test('Should call saved callback after saving the language', () {
      final future = new Future.value(true);
      when(_mockStorage.setLanguage('eu'))
        .thenAnswer((_) => future);

      _languageSwitcherPresenter.onLanguageClicked(Locales.euskara);

      future.then((_) {
        verify(_mockLanguageSwitcherView.onLanguageSaved(Locales.euskara));
      });
    });

    test('Should call error callback if language can not be save', () {
      final future = new Future.value(false);
      when(_mockStorage.setLanguage('eu'))
        .thenAnswer((_) => future);

      _languageSwitcherPresenter.onLanguageClicked(Locales.euskara);

      future.then((_) {
        verify(_mockLanguageSwitcherView.onLanguageSavedError());
      });
    });
  });
}
