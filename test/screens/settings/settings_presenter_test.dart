// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../../lib/screens/settings/settings_presenter.dart';

class MockSettingsScreenView extends Mock implements SettingsScreenViewContract {}

void main() {
  MockSettingsScreenView _mockSettingsScreenView;
  SettingsScreenPresenter _settingsScreenPresenter;

  setUp(() async {
    _mockSettingsScreenView = MockSettingsScreenView();
    _settingsScreenPresenter = SettingsScreenPresenter(_mockSettingsScreenView);
  });

  group('onBackButtonClicked', () {
    test('Should navigate back', () {
      _settingsScreenPresenter.onBackButtonClicked();
      verify(_mockSettingsScreenView.navigateBack());
    });
  });
}
