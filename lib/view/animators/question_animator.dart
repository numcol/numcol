// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../styles.dart';
import 'animator.dart';

class QuestionAnimator extends Animator {
  QuestionAnimator({
    @required TickerProviderStateMixin vsync,
    @required int milliseconds,
    @required Function onDismissed,
    @required Function listener,
  }) : super(
    vsync: vsync,
    milliseconds: milliseconds,
    listener: listener,
  ) {
    _animation = ColorTween(begin: ScreenColors.black, end: ScreenColors.darkRed)
                    .animate(controller);

    controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.stop();
        onDismissed?.call();
      }
    });
  }

  Animation _animation;
  Animation get animation => _animation;
}
