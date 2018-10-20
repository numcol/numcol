// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../domain/index.dart';
import 'animator.dart';

class GameTimerAnimator extends Animator implements TimerContract {
  GameTimerAnimator({
    @required TickerProviderStateMixin vsync,
    @required int milliseconds,
    @required Function onCompleted
  }) : super(
    vsync: vsync,
    milliseconds: milliseconds,
    onCompleted: onCompleted,
  ) {
    _maxTimeInMillisecondxs = milliseconds;
  }

  Animation<double> get animation => controller;
  int _maxTimeInMillisecondxs;

  @override
  int get elapsedInMilliseconds => controller.lastElapsedDuration.inMilliseconds;

  @override
  int get maxTimeInMilliseconds => _maxTimeInMillisecondxs;

  @override
  void start(int durationsTimeInMilliseconds) {
    controller.stop();
    double startingPoint;
    if (durationsTimeInMilliseconds > controller.duration.inMilliseconds) {
      _maxTimeInMillisecondxs = controller.duration.inMilliseconds;
      startingPoint = 0.0;
    } else {
      _maxTimeInMillisecondxs = durationsTimeInMilliseconds;
      var startingMilliseconds = controller.duration.inMilliseconds - durationsTimeInMilliseconds;
      startingPoint = startingMilliseconds / controller.duration.inMilliseconds;
    }
    controller.forward(from: startingPoint);
  }
}
