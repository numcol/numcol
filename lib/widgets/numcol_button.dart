import 'package:flutter/material.dart';

import '../view/index.dart';
import '../engine/index.dart' as Engine;

typedef NumcolButtonPressed();

class NumcolButton extends StatelessWidget {
  NumcolButton({Key key, @required this.color, @required this.text, @required this.onPressed})
      : super(key: key);

  final NumcolButtonPressed onPressed;
  final Engine.Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontFamily: Fonts.lemonMilk
    );
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
