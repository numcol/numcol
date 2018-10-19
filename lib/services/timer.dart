// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

typedef void TimerEndCallback();

class TimerFactory {
  Timer create(
      maxTimeInMilliseconds,
      timePenaltyMultiplier,
      timeAdditionByAnswerInMilliseconds,
      timerEndCallback
    ) {
    return Timer(maxTimeInMilliseconds, timePenaltyMultiplier, timeAdditionByAnswerInMilliseconds, timerEndCallback);
  }
}

class Timer {
  Timer(
    this._maxTimeInMilliseconds,
    this._timePenaltyMultiplier,
    this._timeAdditionByAnswerInMilliseconds,
    this._timerEndCallback
  );

  final double _timePenaltyMultiplier;
  final int _timeAdditionByAnswerInMilliseconds;
  final TimerEndCallback _timerEndCallback;

  TickerProvider _vsync;

  ValueNotifier<AnimationController> _controller;
  ValueNotifier<AnimationController> get controller => _controller;

  int _maxTimeInMilliseconds;
  int get maxTimeInMilliseconds => _maxTimeInMilliseconds;
  int get remainingInMilliseconds => _maxTimeInMilliseconds - _controller.value.lastElapsedDuration.inMilliseconds;

  void _animationStatusCallback(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _timerEndCallback();
    }
  }

  void start(TickerProvider vsync) {
    _vsync = vsync;

    _controller = ValueNotifier(_newController());
    _controller.value.forward();
  }

  void success() {
    var oldController = _controller.value;
    var remaining = oldController.duration.inMilliseconds - oldController.lastElapsedDuration.inMilliseconds;
    oldController.stop();
    _maxTimeInMilliseconds = remaining + _timeAdditionByAnswerInMilliseconds;

    _controller.value = _newController();
    _controller.value.forward();

    oldController.dispose();
  }

  bool fail() {
    var oldController = _controller.value;
    var remaining = oldController.duration.inMilliseconds - oldController.lastElapsedDuration.inMilliseconds;
    oldController.stop();
    _maxTimeInMilliseconds = (remaining * _timePenaltyMultiplier).ceil();
    var gameOver = _maxTimeInMilliseconds <= 0;

    if (!gameOver) {
      _controller.value = _newController();
      _controller.value.forward();
    }

    oldController.dispose();

    return gameOver;
  }

  void dispose() {
    _controller?.dispose();
  }

  AnimationController _newController() {
    return AnimationController(
      duration: Duration(milliseconds: _maxTimeInMilliseconds),
      vsync: _vsync,
    )..addStatusListener(_animationStatusCallback);
  }
}
