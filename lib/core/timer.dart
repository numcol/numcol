import 'package:flutter/material.dart';

class Timer {
  Timer(this._maxTimeInMilliseconds);

  TickerProvider _vsync;

  AnimationController _controller;
  AnimationController get controller => _controller;

  int _maxTimeInMilliseconds;
  int get maxTimeInMilliseconds => _maxTimeInMilliseconds;

  void start(TickerProvider vsync) {
    _vsync = vsync;

    _controller = _newController();
    _controller.forward();
  }

  void success(int millisecondsToIncrease) {
    var oldController = _controller..stop();
    var remaining = oldController.duration.inMilliseconds - oldController.lastElapsedDuration.inMilliseconds;
    _maxTimeInMilliseconds = remaining + millisecondsToIncrease;

    _controller = _newController();
    _controller.forward();

    oldController.dispose();
  }

  bool fail(int millisecondsToDecrease) {
    var oldController = _controller..stop();
    var remaining = oldController.duration.inMilliseconds - oldController.lastElapsedDuration.inMilliseconds;
    _maxTimeInMilliseconds = remaining - millisecondsToDecrease;
    var gameOver = _maxTimeInMilliseconds <= 0;

    if (!gameOver) {
      _controller = _newController();
      _controller.forward();
    }

    oldController.dispose();

    return gameOver;
  }

  void dispose() {
    _controller?.dispose();
  }

  AnimationController _newController() {
    return AnimationController(
      duration: Duration(milliseconds: _maxTimeInMilliseconds),
      vsync: _vsync,
    );
  }
}
