// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';

import '../domain/index.dart';
import 'animator.dart';

class GameTimerAnimator extends Animator implements TimerContract {
  GameTimerAnimator({
    @required TickerProviderStateMixin vsync,
    @required int milliseconds,
  }) : super(
          vsync: vsync,
          milliseconds: milliseconds,
        ) {
    _maxTimeInMillisecondxs = milliseconds;
    controller.addStatusListener(_statusListener);
  }

  final StreamController<Null> _gameOverStreamer = StreamController.broadcast();

  Animation<double> get animation => controller;
  int _maxTimeInMillisecondxs;

  @override
  int get elapsedInMilliseconds =>
      controller.lastElapsedDuration.inMilliseconds;

  @override
  int get maxTimeInMilliseconds => _maxTimeInMillisecondxs;

  @override
  Stream get gameoverStream => _gameOverStreamer.stream;

  @override
  void start(int durationsTimeInMilliseconds) {
    controller.stop();
    double startingPoint;
    if (durationsTimeInMilliseconds > controller.duration.inMilliseconds) {
      _maxTimeInMillisecondxs = controller.duration.inMilliseconds;
      startingPoint = 0.0;
    } else {
      _maxTimeInMillisecondxs = durationsTimeInMilliseconds;
      var startingMilliseconds =
          controller.duration.inMilliseconds - durationsTimeInMilliseconds;
      startingPoint = startingMilliseconds / controller.duration.inMilliseconds;
    }
    controller.forward(from: startingPoint);
  }

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _gameOverStreamer.add(null);
    }
  }
}
