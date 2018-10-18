// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class AnimatorFactory {
  Animator create(TickerProviderStateMixin vsync, int seconds) {
    return Animator(vsync, seconds);
  }
}

class Animator {
  Animator(TickerProviderStateMixin vsync, int seconds) {
    _controller = AnimationController(
      vsync: vsync,
      duration: Duration(seconds: seconds),
    );
  }

  AnimationController _controller;
  Animation _animation;
  Animation get animation => _animation;

  loadIntegerAnimation({
    @required int begin,
    @required int end,
    Function onDismissed,
    Function onForward,
    Function onReverse,
    Function onCompleted,
  }) {
    _animation = StepTween(
        begin: begin,
        end: end,
      ).animate(_controller)
      ..addStatusListener((animationStatus) {
        switch (animationStatus) {
          case AnimationStatus.dismissed:
            onDismissed?.call();
            break;
          case AnimationStatus.forward:
            onForward?.call();
            break;
          case AnimationStatus.reverse:
            onReverse?.call();
            break;
          case AnimationStatus.completed:
            onCompleted?.call();
            break;
          default:
        }
      });
  }

  void forward({ double from }) {
    _controller.forward(from: from);
  }

  void dispose() {
    _controller.dispose();
  }
}
