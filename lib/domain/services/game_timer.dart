// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../contracts/timer.dart';

class GameTimer {
  GameTimer(
    this._timer,
    this._initialMaxTimeInMilliseconds,
    this._timePenaltyMultiplier,
    this._timeAdditionByAnswerInMilliseconds,
  );

  final TimerContract _timer;
  final double _timePenaltyMultiplier;
  final int _timeAdditionByAnswerInMilliseconds;

  TimerContract get timer => _timer;

  int _initialMaxTimeInMilliseconds;
  int get maxTimeInMilliseconds => _timer.maxTimeInMilliseconds;
  int get remainingInMilliseconds => _timer.maxTimeInMilliseconds - _timer.elapsedInMilliseconds;

  void start() {
    _timer.start(_initialMaxTimeInMilliseconds);
  }

  void success() {
    var newTime = remainingInMilliseconds + _timeAdditionByAnswerInMilliseconds;
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
