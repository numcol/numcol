// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

abstract class Animator {
  Animator({
    @required TickerProviderStateMixin vsync,
    @required int seconds,
    this.onDismissed,
    this.onForward,
    this.onReverse,
    this.onCompleted,
  }) {
    controller = AnimationController(
      vsync: vsync,
      duration: Duration(seconds: seconds),
    );
  }

  final Function onDismissed;
  final Function onForward;
  final Function onReverse;
  final Function onCompleted;

  @protected
  AnimationController controller;

  Animation get animation;

  @protected
  void statusListener(AnimationStatus animationStatus) {
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
  }

  void forward({ double from }) {
    controller.forward(from: from);
  }

  void dispose() {
    controller.dispose();
  }
}
