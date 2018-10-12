import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart' hide Color;

import 'answer_content.dart';

typedef void AnswerCallback(Answer val);

class AnswerWidget extends StatelessWidget {
  AnswerWidget(this._answer, this.callback);

  final AnswerCallback callback;
  final Answer _answer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        callback(_answer);
      },
      child: AnswerContentWidget(this._answer),
    );
  }
}
