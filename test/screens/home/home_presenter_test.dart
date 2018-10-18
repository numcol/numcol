// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../../lib/routes.dart';
import '../../../lib/screens/home/home_presenter.dart';

class MockHomeScreenView extends Mock implements HomeScreenViewContract {}

void main() {
  MockHomeScreenView _mockHomeScreenView;
  HomeScreenPresenter _homeScreenPresenter;

  setUp(() async {
    _mockHomeScreenView = MockHomeScreenView();
    _homeScreenPresenter = HomeScreenPresenter(_mockHomeScreenView);
  });

  group('onPlayButtonClicked', () {
    test('Should navigate to countdown page', () {
      _homeScreenPresenter.onPlayButtonClicked();
      verify(_mockHomeScreenView.navigateTo(Routes.countdown));
    });
  });

  group('onZenModeButtonClicked', () {
    test('Should navigate to countdown page', () {
      _homeScreenPresenter.onZenModeButtonClicked();
      verify(_mockHomeScreenView.navigateTo(Routes.countdown));
    });
  });

  group('onTopScoreButtonClicked', () {
    test('Should navigate to countdown page', () {
      _homeScreenPresenter.onTopScoreButtonClicked();
      verify(_mockHomeScreenView.navigateTo(Routes.countdown));
    });
  });

  group('onSettingsButtonClicked', () {
    test('Should navigate to countdown page', () {
      _homeScreenPresenter.onSettingsButtonClicked();
      verify(_mockHomeScreenView.navigateTo(Routes.settings));
    });
  });
}
