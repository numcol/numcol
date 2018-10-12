import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart';
import 'answer/answer.dart';

class AnswersWidget extends StatelessWidget {
  AnswersWidget(this._answers, this.callback);

  final AnswerCallback callback;
  final List<Answer> _answers;

  void answerTaped (Answer answer) {
    callback(answer);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> answers = _answers.map((answer) {
      return AnswerWidget(answer, answerTaped);
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
