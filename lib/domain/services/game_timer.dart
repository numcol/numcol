// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'dart:math';

import '../contracts/index.dart';

class GameTimer {
  GameTimer(
    this._timer,
    this._initialMaxTimeInMilliseconds,
    this._timeReducerMultiplier,
    this._timePenaltyMultiplier,
    this._timeAdditionByAnswerInMilliseconds,
  );

  final TimerContract _timer;
  final double _timeReducerMultiplier;
  final double _timePenaltyMultiplier;
  final int _timeAdditionByAnswerInMilliseconds;
  final int _initialMaxTimeInMilliseconds;

  Stream get gameoverStream => _timer.gameoverStream;
  int get maxTimeInMilliseconds => _timer.maxTimeInMilliseconds;
  int get remainingInMilliseconds =>
      _timer.maxTimeInMilliseconds - _timer.elapsedInMilliseconds;

  void start() {
    _timer.start(_initialMaxTimeInMilliseconds);
  }

  void success(int successCount) {
    var multiplier = (_timeAdditionByAnswerInMilliseconds *
            pow(_timeReducerMultiplier, successCount))
        .ceil();
    var newTime = remainingInMilliseconds + multiplier;
    _timer.start(newTime);
  }

  bool fail() {
    var newTime = (remainingInMilliseconds * _timePenaltyMultiplier).ceil();
    var gameOver = newTime <= 0;

    if (gameOver) {
      _timer.stop();
    } else {
      _timer.start(newTime);
    }

    return gameOver;
  }
}
