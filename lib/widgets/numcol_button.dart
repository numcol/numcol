import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart' as Engine show Color;

import '../strings.dart';
import '../maps.dart';

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
    var borderColor = new BorderSide(
      color: buttonColor,
      width: 3.0,
    );
    var borderDarkColor = new BorderSide(
      color: buttonDarkColor,
      width: 3.0,
    );

    return GestureDetector(
      onTapDown: (details) {
        onPressed(); /*ReplyInheritedWidget.of(context).reply.value = _answer;*/
      },
      child: Container(
        child: Center(

            child: new Stack(
              children: [
                new Positioned(
                  top: 1.0,
                  left: 1.0,
                  child: Text(
                    text,
                    style: style.copyWith(color: Colors.black.withOpacity(0.5)),
                  ),
                ),
                new Container(
                  padding: const EdgeInsets.all(1.0),
                  child: BackdropFilter(
                    filter: new ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                    child: new Text(text, style: style),
                  ),
                ),
              ],
            ),

        ),
        decoration: BoxDecoration(
          color: buttonColor,
          border: new Border(
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
