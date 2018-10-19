// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../../lib/routes.dart';
import '../../../lib/screens/gameover/gameover_presenter.dart';

class MockGameoverScreenView extends Mock implements GameoverScreenViewContract {}

void main() {
  MockGameoverScreenView _mockGameoverScreenView;
  GameoverScreenPresenter _gameoverScreenPresenter;

  setUp(() async {
    _mockGameoverScreenView = MockGameoverScreenView();
    _gameoverScreenPresenter = GameoverScreenPresenter(_mockGameoverScreenView);
  });

  group('Gameover Screen:', () {
    group('On "try again" button pressed', () {
      test('Should redirect to the countdown screen', () {
        _gameoverScreenPresenter.onTryAgainButtonPressed();
        verify(_mockGameoverScreenView.redirectTo(Routes.countdown));
      });
    });

    group('On "back" button pressed', () {
      test('Should navigate back', () {
        _gameoverScreenPresenter.onBackButtonPressed();
        verify(_mockGameoverScreenView.navigateBack());
      });
    });
  });
}
