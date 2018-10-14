import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart' hide Color;

import '../../../widgets/numcol_button.dart';
import '../../../maps.dart';
import 'reply.dart';

typedef void AnswerCallback(Answer val);

class AnswerWidget extends StatelessWidget {
  const AnswerWidget({Key key, @required this.answer}): super(key: key);

  final Answer answer;

  @override
  Widget build(BuildContext context) {
    return NumcolButton(
      color: answer.color,
      text: numbers[answer.number],
      onPressed: () => ReplyInheritedWidget.of(context).reply.value = answer,
    );
  }
}
