// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../styles.dart';
import '../../middleware/index.dart';

class QuestionAnimator extends Animator {
  QuestionAnimator({
    @required TickerProviderStateMixin vsync,
    @required int milliseconds,
  }) : super(
          vsync: vsync,
          milliseconds: milliseconds,
        ) {
    _animation =
        ColorTween(begin: ScreenColors.black, end: ScreenColors.darkRed)
            .animate(controller);

    controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
    });
  }

  Animation _animation;
  Animation get animation => _animation;
}
