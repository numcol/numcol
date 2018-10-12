import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart';

import '../../../translations.dart';
import '../../../maps.dart';
import '../../../strings.dart';

class QuestionWidget extends StatelessWidget {
  QuestionWidget(this._question);

  final Answer _question;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50.0, bottom: 25.0),
      child: Text(
        (
          Translations.of(context).text(numberWords[_question.number]) +
          ' ' +
          Translations.of(context).text(colorWords[_question.color])
        ).toUpperCase(),
        style: TextStyle(
          fontFamily: Fonts.poiretone,
          fontSize: 36.0
        ),
      ),
    );
  }
}
