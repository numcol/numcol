// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../../view/index.dart';

class CountdownWidget extends AnimatedWidget {
  CountdownWidget({Key key, @required this.animation})
      : super(key: key, listenable: animation);

  final Animation<int> animation;

  @override
  build(BuildContext context) {
    return Container(
      height: Responsive.getValue(context, 260.0, 320.0, 420.0),
      width: Responsive.getValue(context, 260.0, 320.0, 420.0),
      child: Center(
        child: Text(
          animation.value == 0 ? 'Go!' : animation.value.toString(),
          style: TextStyle(
            fontSize: Responsive.getValue(context, 92.0, 116.0, 132.0),
            fontFamily: Fonts.poiretone,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: ScreenColors.lightGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(
            Responsive.getValue(context, 130.0, 160.0, 210.0),
          ),
        ),
      ),
    );
  }
}
