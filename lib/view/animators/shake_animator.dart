// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'dart:math';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/material.dart';

import '../../middleware/index.dart';

class ShakeAnimator extends Animator {
  ShakeAnimator({
    @required TickerProviderStateMixin vsync,
    @required Function listener,
  }) : super(vsync: vsync, milliseconds: 200, listener: listener) {
    controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
    });
  }

  Animation get animation => controller;

  Matrix4 get translation {
    double progress = controller.value;
    double offset = sin(progress * pi * 2) * 3;
    return Matrix4.translation(Vector3(offset, 0.0, 0.0));
  }
}
