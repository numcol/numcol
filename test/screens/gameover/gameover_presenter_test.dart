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

  group('onTryAgainButtonClicked', () {
    test('Should redirect to the countdown screen', () {
      _gameoverScreenPresenter.onTryAgainButtonClicked();
      verify(_mockGameoverScreenView.redirectTo(Routes.countdown));
    });
  });

  group('onBackButtonClicked', () {
    test('Should navigate back', () {
      _gameoverScreenPresenter.onBackButtonClicked();
      verify(_mockGameoverScreenView.navigateBack());
    });
  });
}
