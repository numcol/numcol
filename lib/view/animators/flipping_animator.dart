// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../middleware/index.dart';

class FlippingAnimator extends Animator {
  FlippingAnimator({
    @required TickerProviderStateMixin vsync,
    @required Function onFlip,
  }) : super(
          vsync: vsync,
          milliseconds: 150,
        ) {
    _animation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 0.5, curve: Curves.easeIn),
    ));
    controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        onFlip?.call();
        controller.reverse();
      }
    });
  }

  Animation _animation;
  Animation get animation => _animation;

  Widget builder(BuildContext context, Widget child) {
    final Matrix4 transform = new Matrix4.identity()
      ..scale(1.0, _animation.value, 1.0);
    return new Transform(
      transform: transform,
      alignment: FractionalOffset.center,
      child: child,
    );
  }
}
