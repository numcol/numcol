// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart' hide Color;

import '../../middleware/index.dart';
import '../../domain/index.dart';
import '../injector.dart';
import 'numcol_button.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key key,
    @required this.text,
    @required this.color,
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final Color color;
  final NumcolButtonPressed onPressed;

  @override
  Widget build(BuildContext context) {
    var audio = Injector.of(context).inject<AudioPlayer>();
    var isLarge = MediaQuery.of(context).size.width > 540;
    return Container(
      padding: const EdgeInsets.only(
        top: 15.0,
      ),
      height: isLarge ? 80.0 : 60.0,
      width: isLarge ? 360.0 : 240.0,
      child: NumcolButton(
          color: color,
          text: text,
          onPressed: () {
            audio.playClickSound();
            onPressed?.call();
          }),
    );
  }
}
