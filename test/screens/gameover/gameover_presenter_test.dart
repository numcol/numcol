// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../../lib/domain/index.dart';
import '../../../lib/screens/gameover/gameover_presenter.dart';

class MockGameoverScreenView extends Mock implements GameoverScreenViewContract {}
class MockStorage extends Mock implements StorageContract {}
class MockSharer extends Mock implements SharerContract {}

void main() {
  MockGameoverScreenView _mockGameoverScreenView;
  MockStorage _mockStorage;
  MockSharer _mockSharer;
  GameoverScreenPresenter _gameoverScreenPresenter;

  group('Gameover Screen:', () {

    setUp(() async {
      _mockGameoverScreenView = MockGameoverScreenView();
      _mockStorage = MockStorage();
      _mockSharer = MockSharer();
      _gameoverScreenPresenter = GameoverScreenPresenter(_mockGameoverScreenView, _mockStorage, _mockSharer);
    });

    group('On load', () {
      group('when there is not a new top score', () {
        const previousTopScore = 1000;
        const currentScore = 500;

        setUp(() async {
          when(_mockStorage.getTopScore())
            .thenReturn(previousTopScore);
        });

        test('it shows previous top score', () {
          _gameoverScreenPresenter.onLoad(currentScore);

          verify(_mockGameoverScreenView.setTopScore(previousTopScore, false));
        });

        test('it does not save previous top score', () {
          _gameoverScreenPresenter.onLoad(currentScore);

          verifyNever(_mockStorage.setTopScore(any));
        });
      });

      group('when there is a new top score', () {
        const previousTopScore = 500;
        const currentScore = 1000;
        final isSavedFuture = new Future.value(true);

        setUp(() async {
          when(_mockStorage.getTopScore())
            .thenReturn(previousTopScore);
          when(_mockStorage.setTopScore(any))
            .thenAnswer((_) => isSavedFuture);
        });

        test('it shows current score as top score', () {
          _gameoverScreenPresenter.onLoad(currentScore);

          verify(_mockGameoverScreenView.setTopScore(any, any));
        });

        test('it saves current score as top score', () {
          _gameoverScreenPresenter.onLoad(currentScore);

          verify(_mockStorage.setTopScore(currentScore));
        });
      });

      group('when there is a new top score but it can be saved', () {
        const previousTopScore = 500;
        const currentScore = 1000;
        final isSavedFuture = new Future.value(false);

        setUp(() async {
          when(_mockStorage.getTopScore())
            .thenReturn(previousTopScore);
          when(_mockStorage.setTopScore(any))
            .thenAnswer((_) => isSavedFuture);
        });

        test('it shows current score as top score', () {
          _gameoverScreenPresenter.onLoad(currentScore);

          verify(_mockGameoverScreenView.setTopScore(any, any));
        });

        test('it shows error message', () {
          _gameoverScreenPresenter.onLoad(currentScore);

          isSavedFuture.then((_) {
            verify(_mockGameoverScreenView.onTopscoreSavedError());
          });
        });
      });
    });

    group('On "try again" button pressed', () {
      test('it redirects to the countdown screen', () {
        _gameoverScreenPresenter.onTryAgainButtonPressed();
        verify(_mockGameoverScreenView.redirectTo(Routes.countdown));
      });
    });

    group('On "back" button pressed', () {
      test('it navigates back', () {
        _gameoverScreenPresenter.onBackButtonPressed();
        verify(_mockGameoverScreenView.navigateBack());
      });
    });

    group('On "share" button pressed', () {
      test('it launches the native sharer with a text that includes score', () {
        _gameoverScreenPresenter.onShareButtonPressed('text', 123);
        verify(_mockSharer.shareScore('text', 123));
      });
    });
  });
}
