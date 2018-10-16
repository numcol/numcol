// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../../styles.dart';

class RemainingCounter extends AnimatedWidget {
  RemainingCounter({ Key key, @required this.animation }) : super(key: key, listenable: animation);

  final Animation<int> animation;

  @override
  build(BuildContext context){
    return new Text(
      (animation.value / 1000).toStringAsFixed(3).padLeft(6, '0'),
      style: TextStyle(
        fontSize: 18.0,
        fontFamily: Fonts.robotoMono,
      ),
    );
  }
}
