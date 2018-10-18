// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart';

import '../answer/answer.dart';

class AnswersWidget extends StatelessWidget {
  AnswersWidget({Key key, @required this.answers}) : super(key: key);

  final List<ValueNotifier<Answer>> answers;

  @override
  Widget build(BuildContext context) {
    List<Widget> answerWidgets = answers.map((answer) {
      return AnswerWidget(
        answer: answer
      );
    }).toList();

    return GridView.count(
      primary: false,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      crossAxisCount: 6,
      children: answerWidgets,
    );
  }
}
