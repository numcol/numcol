// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../../lib/domain/index.dart';
import '../../../lib/screens/home/home_presenter.dart';

class MockHomeScreenView extends Mock implements HomeScreenViewContract {}
class MockSharer extends Mock implements SharerContract {}

void main() {
  MockHomeScreenView _mockHomeScreenView;
  HomeScreenPresenter _homeScreenPresenter;
  MockSharer _mockSharer;

  setUp(() async {
    _mockHomeScreenView = MockHomeScreenView();
    _mockSharer = MockSharer();
    _homeScreenPresenter = HomeScreenPresenter(_mockHomeScreenView, _mockSharer);
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

    group('On "Rate App" button pressed', () {
      test('it navigates to countdown page', () {
        _homeScreenPresenter.onRateButtonPressed();
        verify(_mockSharer.rateApp());
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
