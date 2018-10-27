// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../i18n/index.dart';
import '../styles.dart';

class GameIndicator extends StatelessWidget {
  const GameIndicator({Key key, @required this.title, @required this.value})
      : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    var isLarge = MediaQuery.of(context).size.width > 540;

    return Column(
      children: <Widget>[
        Text(
          Translations.of(context).text(title),
          style: TextStyle(
            fontSize: isLarge ? 18.0 : 14.0,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isLarge ? 24.0 : 18.0,
            fontFamily: Fonts.robotoMono,
          ),
        ),
      ],
    );
  }
}
