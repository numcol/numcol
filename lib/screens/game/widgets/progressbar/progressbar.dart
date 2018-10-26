// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../../middleware/index.dart';
import '../../../../view/index.dart';

class ProgressBarWidget extends StatefulWidget {
  ProgressBarWidget({Key key, @required this.animator}) : super(key: key);

  final GameTimerAnimator animator;

  @override
  _ProgressBarWidgetState createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget> {
  @override
  Widget build(BuildContext context) {
    var animation =
        Tween(begin: 1.0, end: 0.0).animate(widget.animator.animation)
          ..addListener(() {
            setState(() => null);
          });

    var colorAnimation = ColorTween(
      begin: ScreenColors.green,
      end: ScreenColors.red,
    ).animate(widget.animator.animation)
      ..addListener(() {
        setState(() => null);
      });
    return Container(
      child: LinearProgressIndicator(
        value: animation.value,
        valueColor: colorAnimation,
        backgroundColor: ScreenColors.lightGrey,
      ),
    );
  }
}
