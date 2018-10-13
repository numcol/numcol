import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart' hide Color;

import 'widgets/index.dart';
import '../reply.dart';

typedef void AnswerCallback(Answer val);

class AnswerWidget extends StatelessWidget {
  const AnswerWidget(this._answer);

  final Answer _answer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        ReplyInheritedWidget.of(context).reply.value = _answer;
      },
      child: AnswerContentWidget(this._answer),
    );
  }
}
