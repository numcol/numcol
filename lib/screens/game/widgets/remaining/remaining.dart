// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../../i18n/index.dart';
import '../../../../view/index.dart';

class RemainingWidget extends AnimatedWidget {
  RemainingWidget({Key key, @required this.animation})
      : super(key: key, listenable: animation);

  final Animation<int> animation;

  @override
  build(BuildContext context) {
    return GameIndicator(
      title: 'time',
      value: (animation.value / 1000).toStringAsFixed(3).padLeft(6, '0'),
    );
  }
}
