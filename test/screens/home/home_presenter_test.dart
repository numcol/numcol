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

  group('Home Screen:', () {
    group('On "Play" button pressed ', () {
      test('it navigates to countdown page', () {
        _homeScreenPresenter.onPlayButtonPressed();
        verify(_mockHomeScreenView.navigateTo(Routes.countdown));
      });
    });

    group('On "Zen Mode" button pressed', () {
      test('it navigates to countdown page', () {
        _homeScreenPresenter.onZenModeButtonPressed();
        verify(_mockHomeScreenView.navigateTo(Routes.countdown));
      });
    });

    group('On "Top Score" button pressed', () {
      test('it navigates to countdown page', () {
        _homeScreenPresenter.onTopScoreButtonPressed();
        verify(_mockHomeScreenView.navigateTo(Routes.countdown));
      });
    });

    group('On "Settings" button pressed', () {
      test('it navigates to countdown page', () {
        _homeScreenPresenter.onSettingsButtonPressed();
        verify(_mockHomeScreenView.navigateTo(Routes.settings));
      });
    });
  });
}
