// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../view/animators/index.dart';
import '../middleware/index.dart';

class AnimatorFactory {
  CountdownAnimator createCountdownAnimator({
    @required TickerProviderStateMixin vsync,
    @required int seconds,
    @required Function onCompleted,
    @required int begin,
    @required int end,
  }) {
    return CountdownAnimator(
      vsync: vsync,
      seconds: seconds,
      onCompleted: onCompleted,
      begin: begin,
      end: end,
    );
  }

  GameTimerAnimator createGameAnimator({
    @required TickerProviderStateMixin vsync,
    @required int milliseconds,
  }) {
    return GameTimerAnimator(
      vsync: vsync,
      milliseconds: milliseconds,
    );
  }

  QuestionAnimator createQuestionAnimator({
    @required TickerProviderStateMixin vsync,
    @required int milliseconds,
  }) {
    return QuestionAnimator(
      vsync: vsync,
      milliseconds: milliseconds,
    );
  }
}
