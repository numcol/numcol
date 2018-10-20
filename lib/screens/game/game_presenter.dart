// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../../domain/index.dart';

abstract class GameScreenViewContract implements NavigatorContract {}

class GameScreenPresenter {
  GameScreenPresenter(this._view, this._timer, this._game);

  final Game _game;
  final GameScreenViewContract _view;
  final GameTimer _timer;

  List<Answer> get answers => _game.answers;
  Answer get question => _game.question;
  int get score => _game.score;

  void onLoad() {
    _game.start();
    _timer.start();
  }

  int onAnswerPressed(Answer answer) {
    if (_game.checkAnswer(answer)) {
      var answerIndex = _game.nextQuestion(answer, _timer.remainingInMilliseconds, _timer.maxTimeInMilliseconds);
      _timer.success();

      return answerIndex;
    }

    var isGameOver = _timer.fail();
    if (isGameOver) {
      onGameOver();
    }

    return -1;
  }

  void onGameOver() {
    _view.redirectTo(Routes.gameover);
  }
}
