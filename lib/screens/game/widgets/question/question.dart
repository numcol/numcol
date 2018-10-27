// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

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
  QuestionWidget({Key key, @required this.question}) : super(key: key);

  final ValueNotifier<Question> question;

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget>
    with TickerProviderStateMixin
    implements QuestionViewContract {
  QuestionAnimator _colorAnimator;
  QuestionAnimator _numberAnimator;
  QuestionPresenter _presenter;
  Question _question;

  QuestionAnimator _createAnimator() {
    return Injector.of(context)
        .inject<AnimatorFactory>()
        .createQuestionAnimator(
          vsync: this,
          milliseconds: 400,
        );
  }

  QuestionAnimator get colorAnimator => _colorAnimator;
  QuestionAnimator get numberAnimator => _numberAnimator;
  Question get question => _question;

  void _setQuestion() {
    setState(() => _question = widget.question.value);
  }

  void _onReply(Reply reply) {
    _presenter.onReply(reply);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _colorAnimator = _createAnimator();
    _numberAnimator = _createAnimator();
    _question = widget.question.value;
    _presenter = QuestionPresenter(this);
    widget.question.addListener(_setQuestion);
    var game = Injector.of(context).inject<Game>();
    game.replyStream.listen(_onReply);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Responsive.getValue(context, 50.0, 80.0, 80.0),
        bottom: Responsive.getValue(context, 25.0, 70.0, 70.0),
      ),
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
    widget.question.removeListener(_setQuestion);
    _colorAnimator.dispose();
    _numberAnimator.dispose();
    super.dispose();
  }
}
