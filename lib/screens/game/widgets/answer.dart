// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart' hide Color;

import '../../../widgets/numcol_button.dart';
import '../../../core/index.dart';
import 'reply.dart';

typedef void AnswerCallback(Answer val);

class AnswerWidget extends StatefulWidget {
  AnswerWidget({Key key, @required this.answer})
    : super(key: key);

  final ValueNotifier<Answer> answer;

  @override
  _AnswerWidgetState createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {

  @override
  void initState() {
    super.initState();
    widget.answer.addListener(() => setState(() => null));
  }

  @override
  Widget build(BuildContext context) {
    return NumcolButton(
      color: widget.answer.value.color,
      text: numbers[widget.answer.value.number],
      onPressed: () => ReplyInheritedWidget.of(context).reply.value = widget.answer.value,
    );
  }
}
