// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'animator.dart';

class CountdownAnimator extends Animator {
  CountdownAnimator({
    @required TickerProviderStateMixin vsync,
    @required int seconds,
    Function onDismissed,
    Function onForward,
    Function onReverse,
    @required Function onCompleted,
    @required int begin,
    @required int end,
  }) : super(
    vsync: vsync,
    seconds: seconds,
    onDismissed: onDismissed,
    onForward: onForward,
    onReverse: onReverse,
    onCompleted: onCompleted,
  ) {
    _animation = StepTween(
        begin: begin,
        end: end,
      ).animate(controller)
      ..addStatusListener(statusListener);
  }

  Animation _animation;
  Animation get animation => _animation;
}
