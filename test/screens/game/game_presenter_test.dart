// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../../lib/routes.dart';
import '../../../lib/domain/index.dart';
import '../../../lib/screens/game/game_presenter.dart';

class MockGameScreenView extends Mock implements GameScreenViewContract {}
class MockTimer extends Mock implements GameTimer {}
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
      test('the game and the timer start', () {
        _gameScreenPresenter.onLoad();
        verifyInOrder([
          _mockGame.start(),
          _mockTimer.start()
        ]);
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

    group('On get answers', () {
      test('it return game answers', () {
        var answers = <Answer>[
          Answer(Color.blue, Number.one),
        ];
        when(_mockGame.answers)
          .thenReturn(answers);
        expect(_gameScreenPresenter.answers, answers);
      });
    });

    group('On get question', () {
      test('it return game question', () {
        var question = Answer(Color.blue, Number.one);
        when(_mockGame.question)
          .thenReturn(question);
        expect(_gameScreenPresenter.question, question);
      });
    });

    group('On get score', () {
      test('it return game score', () {
        var score = 123;
        when(_mockGame.score)
          .thenReturn(score);
        expect(_gameScreenPresenter.score, score);
      });
    });
  });
}
