// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../../view/index.dart';

class ScoreWidget extends AnimatedWidget {
  ScoreWidget({Key key, @required this.score})
      : super(key: key, listenable: score);

  final ValueNotifier score;

  @override
  build(BuildContext context) {
    return GameIndicator(
      title: 'score',
      value: score.value.toString(),
    );
  }
}
