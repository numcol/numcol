// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../../services/index.dart';
import '../../../../domain/index.dart';
import '../../../../view/index.dart';
import 'question_presenter.dart';
import 'question_animated.dart';

const gameColorWords = {
  Color.blue: 'blue',
  Color.red: 'red',
  Color.green: 'green',
  Color.yellow: 'yellow',
};

const gameNumberWords = {
  Number.one: 'one',
  Number.two: 'two',
  Number.three: 'three',
  Number.four: 'four',
  Number.five: 'five',
  Number.six: 'six',
  Number.seven: 'seven',
  Number.eight: 'eight',
  Number.nine: 'nine',
};

class QuestionWidget extends StatefulWidget {
  QuestionWidget({Key key, @required this.question, @required this.isColorOk, @required this.isNumberOk})
    : super(key: key);

  final ValueNotifier<Answer> question;
  final ValueNotifier<bool> isColorOk;
  final ValueNotifier<bool> isNumberOk;

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> with TickerProviderStateMixin implements QuestionViewContract {
  QuestionAnimator _colorAnimator;
  QuestionAnimator _numberAnimator;
  QuestionPresenter _presenter;

  bool get isNumberOk => widget.isNumberOk.value;
  bool get isColorOk => widget.isColorOk.value;

  set isNumberOk(bool isOk) => widget.isNumberOk.value = isOk;
  set isColorOk(bool isOk) => widget.isColorOk.value = isOk;

  QuestionAnimator _createAnimator(Function completeAnimationCallbak, Function dismissAnimationCallbak) {
    return Injector.of(context).inject<AnimatorFactory>().createQuestionAnimator(
      vsync: this,
      milliseconds: 400,
      onDismissed: dismissAnimationCallbak,
      onCompleted: completeAnimationCallbak,
    );
  }

  void _setState() {
    setState(() => null);
  }

  void _onIsColorAnimationCompleted() {
    _presenter.onIsColorAnimationCompleted();
  }

  void _onIsColorAnimationDismissed() {
    _presenter.onIsColorAnimationDismissed();
  }

  void _onIsNumberAnimationCompleted() {
    _presenter.onIsNumberAnimationCompleted();
  }

  void _onIsNumberAnimationDismissed() {
    _presenter.onIsNumberAnimationDismissed();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _colorAnimator = _createAnimator(_onIsColorAnimationCompleted, _onIsColorAnimationDismissed);
    _numberAnimator = _createAnimator(_onIsNumberAnimationCompleted, _onIsNumberAnimationDismissed);
    _presenter = QuestionPresenter(this, _colorAnimator, _numberAnimator);
    widget.isColorOk.addListener(_presenter.onIsColorOkValueChanged);
    widget.isNumberOk.addListener(_presenter.onIsNumberOkValueChanged);
    widget.question.addListener(_setState);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50.0, bottom: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          QuestionAnimated(
            animation: _numberAnimator.animation,
            text: gameNumberWords[widget.question.value.number],
          ),
          Text(' '),
          QuestionAnimated(
            animation: _colorAnimator.animation,
            text: gameColorWords[widget.question.value.color],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.question.removeListener(_setState);
    widget.isColorOk.removeListener(_presenter.onIsColorOkValueChanged);
    widget.isNumberOk.removeListener(_presenter.onIsNumberOkValueChanged);
    _colorAnimator.dispose();
    _numberAnimator.dispose();
    super.dispose();
  }
}
