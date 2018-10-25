// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../../domain/index.dart' hide Color;
import '../../../../view/index.dart';
import 'answer_presenter.dart';

const gameNumbers = {
  Number.one: '1',
  Number.two: '2',
  Number.three: '3',
  Number.four: '4',
  Number.five: '5',
  Number.six: '6',
  Number.seven: '7',
  Number.eight: '8',
  Number.nine: '9',
};

class AnswerWidget extends StatefulWidget {
  AnswerWidget({Key key, @required this.answer})
      : super(key: key);

  final ValueNotifier<Answer> answer;

  @override
  _AnswerWidgetState createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget>
  with TickerProviderStateMixin implements AnswerViewContract {

  AnswerPresenter _presenter;
  Answer get reply => widget.answer.value;
  ShakeAnimator _shakeAnimator;
  FlippingAnimator _flippingAnimator;
  Answer _currentAnswer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _shakeAnimator = ShakeAnimator(vsync: this, listener: _setState);
    _flippingAnimator = FlippingAnimator(vsync: this, onFlip: _onFlip);
    var game = Injector.of(context).inject<Game>();
    _presenter = AnswerPresenter(this, game);
    widget.answer.addListener(_setState);
    _currentAnswer = widget.answer.value;
  }

  @override
  void renew() {
    _flippingAnimator.forward();
  }

  @override
  void shake() {
    _shakeAnimator.reset();
    _shakeAnimator.forward();
  }

  void _onFlip() {
    setState(() => _currentAnswer = widget.answer.value);
  }

  void _setState() {
    setState(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _flippingAnimator.animation,
      child: Transform(
        transform: _shakeAnimator.translation,
        child: NumcolButton(
          color: _currentAnswer.color,
          text: gameNumbers[_currentAnswer.number],
          onPressed: _presenter.onPressed,
        ),
      ),
      builder: _flippingAnimator.builder,
    );
  }

  @override
  void dispose() {
    _shakeAnimator.dispose();
    super.dispose();
  }
}
