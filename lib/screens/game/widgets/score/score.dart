// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../../view/index.dart';
import '../../../../i18n/index.dart';

class ScoreWidget extends AnimatedWidget {
  ScoreWidget({Key key, @required this.score})
      : super(key: key, listenable: score);

  final ValueNotifier score;

  @override
  build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(Translations.of(context).text('score')),
        Text(
          score.value.toString(),
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: Fonts.robotoMono,
          ),
        ),
      ],
    );
  }
}
