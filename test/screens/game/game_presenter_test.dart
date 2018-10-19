// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../../lib/routes.dart';
import '../../../lib/domain/index.dart';
import '../../../lib/screens/game/game_presenter.dart';
import '../../../lib/services/index.dart';

class MockGameScreenView extends Mock implements GameScreenViewContract {}
class MockTimer extends Mock implements Timer {}
class MockGame extends Mock implements Game {}

void main() {
  MockGameScreenView _mockGameScreenView;
  MockTimer _mockTimer;
  MockGame _mockGame;
  GameScreenPresenter _gameScreenPresenter;

  setUp(() async {
    _mockGameScreenView = MockGameScreenView();
    _mockTimer = MockTimer();
    _mockGame = MockGame();
    _gameScreenPresenter = GameScreenPresenter(_mockGameScreenView, _mockTimer, _mockGame);
  });

  group('Game Screen:', () {
    group('On load', () {
      test('the game starts', () {
        _gameScreenPresenter.onLoad();
        verify(_mockGame.start());
      });
    });

    group('On answer pressed', () {
      group('when it is the correct answer', () {
        const rightAnswer = Answer(Color.red, Number.five);
        const rightAnswerIndex = 1;
        const remainingInMilliseconds = 2;
        const maxTimeInMilliseconds = 4;

        setUp(() async {
          when(_mockTimer.remainingInMilliseconds)
            .thenReturn(remainingInMilliseconds);
          when(_mockTimer.maxTimeInMilliseconds)
            .thenReturn(maxTimeInMilliseconds);
          when(_mockGame.checkAnswer(rightAnswer))
            .thenReturn(true);
          when(_mockGame.nextQuestion(rightAnswer, remainingInMilliseconds, maxTimeInMilliseconds))
            .thenReturn(rightAnswerIndex);
        });

        test('adds extra time', () {
          _gameScreenPresenter.onAnswerPressed(rightAnswer);
          verify(_mockTimer.success());
        });

        test('renews the question', () {
          _gameScreenPresenter.onAnswerPressed(rightAnswer);
          verify(_mockGame.nextQuestion(rightAnswer, remainingInMilliseconds, maxTimeInMilliseconds));
        });

        test('returns the answer id to be able to remove it from the view', () {
          var correctAnswerId = _gameScreenPresenter.onAnswerPressed(rightAnswer);
          expect(correctAnswerId, rightAnswerIndex);
        });
      });

      group('when it is a wrong answer', () {
        const wrongAnswer = Answer(Color.red, Number.five);
        const wrongAnswerIndex = -1;
        const remainingInMilliseconds = 2;
        const maxTimeInMilliseconds = 4;

        setUp(() async {
          when(_mockTimer.remainingInMilliseconds)
            .thenReturn(remainingInMilliseconds);
          when(_mockTimer.maxTimeInMilliseconds)
            .thenReturn(maxTimeInMilliseconds);
          when(_mockGame.checkAnswer(wrongAnswer))
            .thenReturn(false);
          when(_mockGame.nextQuestion(wrongAnswer, remainingInMilliseconds, maxTimeInMilliseconds))
            .thenReturn(wrongAnswerIndex);
        });

        test('triggers a penalty that reduce the remaining time', () {
          when(_mockTimer.fail())
              .thenReturn(false);
          _gameScreenPresenter.onAnswerPressed(wrongAnswer);
          verify(_mockTimer.fail());
        });

        group('if there is still remaining time', () {
          setUp(() async {
            when(_mockTimer.fail())
              .thenReturn(false);
          });

          test('it does not trigger gameover', () {
            _gameScreenPresenter.onAnswerPressed(wrongAnswer);
            verifyNever(_mockGameScreenView.redirectTo(Routes.gameover));
          });

          test('returns wrong response indicator', () {
            var correctAnswerId = _gameScreenPresenter.onAnswerPressed(wrongAnswer);
            expect(correctAnswerId, -1);
          });
        });

        group('if there is not remaining time', () {
          setUp(() async {
            when(_mockTimer.fail())
              .thenReturn(true);
          });

          test('it triggers gameover', () {
            _gameScreenPresenter.onAnswerPressed(wrongAnswer);
            verify(_mockGameScreenView.redirectTo(Routes.gameover));
          });

          test('returns wrong response indicator', () {
            var correctAnswerId = _gameScreenPresenter.onAnswerPressed(wrongAnswer);
            expect(correctAnswerId, -1);
          });
        });
      });
    });

    group('On game over', () {
      test('it redirects to game over screen', () {
        _gameScreenPresenter.onGameOver();
        verify(_mockGameScreenView.redirectTo(Routes.gameover));
      });
    });
  });
}
