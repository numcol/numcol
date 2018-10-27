// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../i18n/index.dart';
import '../styles.dart';

class PageTitle extends StatelessWidget {
  PageTitle({Key key, @required this.tag}) : super(key: key);

  final String tag;

  @override
  Widget build(BuildContext context) {
    var isLarge = MediaQuery.of(context).size.width > 540;
    return Center(
      child: Container(
        padding: isLarge
            ? const EdgeInsets.only(bottom: 50.0)
            : const EdgeInsets.only(bottom: 30.0),
        child: Text(
          Translations.of(context).text(tag).toUpperCase(),
          style: TextStyle(
            fontSize: isLarge ? 60.0 : 42.0,
            color: ScreenColors.black,
            fontFamily: Fonts.poiretone,
          ),
        ),
      ),
    );
  }
}
