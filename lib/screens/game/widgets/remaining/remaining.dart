// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'remaining_counter.dart';
import '../../../../view/animators/game_timer_animator.dart';
import '../../../../i18n/index.dart';

class RemainingWidget extends StatefulWidget {
  RemainingWidget({Key key, @required this.animator}) : super(key: key);

  final GameTimerAnimator animator;

  @override
  _RemainingWidgetState createState() => _RemainingWidgetState();
}

class _RemainingWidgetState extends State<RemainingWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(Translations.of(context).text('time')),
        RemainingCounter(
          animation: StepTween(
            begin: widget.animator.maxTimeInMilliseconds.round(),
            end: 0,
          ).animate(widget.animator.animation),
        ),
      ]
    );
  }
}
