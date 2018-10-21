// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../lib/domain/index.dart';
import '../../../../../lib/screens/settings/widgets/language_switcher/language_switcher_presenter.dart';

class MockLanguageSwitcherView extends Mock implements LanguageSwitcherViewContract {}
class MockStorage extends Mock implements StorageContract {}

void main() {
  MockStorage _mockStorage;
  MockLanguageSwitcherView _mockLanguageSwitcherView;
  LanguageSwitcherPresenter _languageSwitcherPresenter;

  setUp(() async {
    _mockLanguageSwitcherView = MockLanguageSwitcherView();
    _mockStorage = MockStorage();
    _languageSwitcherPresenter = LanguageSwitcherPresenter(_mockLanguageSwitcherView, _mockStorage);
  });

  group('Language Switcher:', () {
    group('On load', () {
      test('it gets user preferred language and if it is empty it does not refresh UI', () {
        when(_mockStorage.getLanguage())
          .thenReturn(null);

        _languageSwitcherPresenter.loadChosenLanguage();

        verify(_mockStorage.getLanguage());
        verifyNever(_mockLanguageSwitcherView.onLoadChosenLanguageComplete(any));
      });

      test('it gets user preferred language and it calls complete action to refresh screen with the loaded locale', () {
        when(_mockStorage.getLanguage())
          .thenReturn('eu');

        _languageSwitcherPresenter.loadChosenLanguage();

        verify(_mockStorage.getLanguage());
        verify(_mockLanguageSwitcherView.onLoadChosenLanguageComplete(Locales.euskara));
      });
    });

    group('On language selected', () {
      test('saves the changes and it notifies the UI about the saved changes', () {
        final future = new Future.value(true);
        when(_mockStorage.setLanguage('eu'))
          .thenAnswer((_) => future);

        _languageSwitcherPresenter.onLanguagePressed(Locales.euskara);

        future.then((_) {
          verify(_mockStorage.setLanguage('eu'));
          verify(_mockLanguageSwitcherView.onLanguageSaved(Locales.euskara));
        });
      });

      test('it notifies the UI about the errors saving changes', () {
        final future = new Future.value(false);
        when(_mockStorage.setLanguage('eu'))
          .thenAnswer((_) => future);

        _languageSwitcherPresenter.onLanguagePressed(Locales.euskara);

        future.then((_) {
          verify(_mockLanguageSwitcherView.onLanguageSavedError());
        });
      });
    });
  });
}
