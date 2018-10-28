// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../i18n/index.dart';
import '../styles.dart';
import '../responsive.dart';

class Congrats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(
          bottom: Responsive.getValue(context, 30.0, 50.0, 70.0),
        ),
        child: Shimmer.fromColors(
          baseColor: ScreenColors.darkBlack,
          highlightColor: ScreenColors.yellow,
          child: Text(
            Translations.of(context).text('congrats').toUpperCase(),
            style: TextStyle(
              fontSize: Responsive.getValue(context, 30.0, 54.0, 72.0),
              fontFamily: Fonts.lemonMilk,
            ),
          ),
        ),
      ),
    );
  }
}
