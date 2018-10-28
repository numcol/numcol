// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../i18n/index.dart';
import '../styles.dart';
import '../responsive.dart';

class PageTitle extends StatelessWidget {
  PageTitle({Key key, @required this.tag}) : super(key: key);

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(
          bottom: Responsive.getValue(context, 30.0, 50.0, 70.0),
        ),
        child: Text(
          Translations.of(context).text(tag).toUpperCase(),
          style: TextStyle(
            fontSize: Responsive.getValue(context, 36.0, 60.0, 80.0),
            color: ScreenColors.black,
            fontFamily: Fonts.poiretone,
          ),
        ),
      ),
    );
  }
}
