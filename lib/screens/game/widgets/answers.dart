import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart';
import 'answer.dart';

class AnswersWidget extends StatelessWidget {
  AnswersWidget(this._answers);

  final List<Answer> _answers;

  @override
  Widget build(BuildContext context) {
    List<Widget> answers = _answers.map((answer) {
      return AnswerWidget(answer);
    }).toList();

    return GridView.count(
      primary: false,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      crossAxisCount: 6,
      children: answers,
    );
  }
}
