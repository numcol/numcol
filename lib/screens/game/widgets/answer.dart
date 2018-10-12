import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart';

class AnswerWidget extends StatelessWidget {
  AnswerWidget(this._answer);

  final Answer _answer;

  @override
  Widget build(BuildContext context) {
    return Text(_answer.color.toString());
  }
}
