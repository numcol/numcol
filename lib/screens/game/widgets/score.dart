// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../styles.dart';
import '../../../services/index.dart';

class ScoreWidget extends StatefulWidget {
  ScoreWidget({Key key, @required this.score})
    : super(key: key);

  final ValueNotifier<int> score;

  @override
  _ScoreWidgetState createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {

  @override
  void initState() {
    super.initState();
    widget.score.addListener(() => setState(() => null));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(Translations.of(context).text('score')),
        Text(
          widget.score.value.toString(),
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: Fonts.robotoMono,
          ),
        ),
      ],
    );
  }
}
