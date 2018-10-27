// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../domain/index.dart' as Engine;
import '../styles.dart';
import '../responsive.dart';

typedef NumcolButtonPressed();

class NumcolButton extends StatelessWidget {
  NumcolButton(
      {Key key,
      @required this.color,
      @required this.text,
      @required this.onPressed})
      : super(key: key);

  final NumcolButtonPressed onPressed;
  final Engine.Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    var fontSize = Responsive.getValue(context, 18.0, 28.0, 36.0);
    var style = TextStyle(
        color: Colors.white, fontSize: fontSize, fontFamily: Fonts.lemonMilk);
    var buttonColor = colors[color];
    var buttonDarkColor = darkColors[color];
    var borderColor = BorderSide(
      color: buttonColor,
      width: 3.0,
    );
    var borderDarkColor = BorderSide(
      color: buttonDarkColor,
      width: 3.0,
    );

    return GestureDetector(
      onTapDown: (details) {
        onPressed();
      },
      child: Container(
        child: Center(
          child: Stack(
            children: [
              Positioned(
                top: 2.0,
                left: 2.0,
                child: Text(
                  text,
                  style: style.copyWith(color: Colors.black.withOpacity(0.4)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(1.0),
                child: Text(text, style: style),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border(
            top: borderColor,
            left: borderColor,
            bottom: borderDarkColor,
            right: borderDarkColor,
          ),
        ),
      ),
    );
  }
}
