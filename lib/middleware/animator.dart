// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../domain/index.dart';

abstract class Animator implements AnimatorContract {
  Animator({
    @required this.vsync,
    @required int milliseconds,
    this.onDismissed,
    this.onForward,
    this.onReverse,
    this.onCompleted,
    this.listener,
  }) {
    controller = newController(milliseconds);
  }

  final TickerProviderStateMixin vsync;
  final Function onDismissed;
  final Function onForward;
  final Function onReverse;
  final Function onCompleted;
  final Function listener;

  @protected
  AnimationController controller;

  Animation get animation;

  @protected
  AnimationController newController(int milliseconds) {
    var controller = AnimationController(
      vsync: vsync,
      duration: Duration(milliseconds: milliseconds),
    );

    if (onCompleted != null ||
        onDismissed != null ||
        onForward != null ||
        onReverse != null) {
      controller.addStatusListener(_statusListener);
    }

    if (listener != null) {
      controller.addListener(_listener);
    }

    return controller;
  }

  void _statusListener(AnimationStatus animationStatus) {
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

  void _listener() {
    listener?.call();
  }

  void forward({double from}) {
    controller.forward(from: from);
  }

  void reverse() {
    controller.reverse();
  }

  void reset() {
    controller.reset();
  }

  void stop() {
    controller.stop();
  }

  void dispose() {
    controller.dispose();
  }
}
