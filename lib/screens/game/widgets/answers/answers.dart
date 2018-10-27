// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../../view/index.dart';
import '../../../../domain/index.dart';
import '../answer/answer.dart';

class AnswersWidget extends StatelessWidget {
  AnswersWidget({Key key, @required this.answers}) : super(key: key);

  final List<ValueNotifier<Answer>> answers;

  @override
  Widget build(BuildContext context) {
    List<Widget> answerWidgets = answers.map((answer) {
      return AnswerWidget(answer: answer);
    }).toList();

    final spacing = Responsive.getValue(context, 10.0, 20.0, 20.0);

    return GridView.count(
      primary: false,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      crossAxisCount: 6,
      children: answerWidgets,
    );
  }
}
