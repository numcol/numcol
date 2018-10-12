import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart';
import '../../../strings.dart';

class QuestionWidget extends StatelessWidget {
  QuestionWidget(this._question);

  final Answer _question;

  @override
  Widget build(BuildContext context) {
    return Text(
      _question.color.toString(),
      style: TextStyle(fontFamily: Fonts.poiretone),
    );
  }
}
