// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../../i18n/index.dart';
import '../../../../view/index.dart';

class QuestionAnimated extends AnimatedWidget {
  QuestionAnimated({Key key, @required this.animation, @required this.text})
      : super(key: key, listenable: animation);

  final Animation animation;
  final String text;

  @override
  build(BuildContext context) {
    return Text(
      Translations.of(context).text(text).toUpperCase(),
      style: TextStyle(
        fontFamily: Fonts.poiretone,
        fontSize: Responsive.getValue(context, 36.0, 54.0, 72.0),
        color: animation.value,
      ),
    );
  }
}
