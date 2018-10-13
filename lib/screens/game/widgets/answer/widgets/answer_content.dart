import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart' hide Color;

import '../../../../../strings.dart';
import '../../../../../maps.dart';

class AnswerContentWidget extends StatelessWidget {
  AnswerContentWidget(this._answer);

  final Answer _answer;

  @override
  Widget build(BuildContext context) {
    var text = numbers[_answer.number];
    var style = TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontFamily: Fonts.lemonMilk
    );
    var color = colors[_answer.color];
    var darkColor = darkColors[_answer.color];
    var borderColor = new BorderSide(
      color: color,
      width: 3.0,
    );
    var borderDarkColor = new BorderSide(
      color: darkColor,
      width: 3.0,
    );

    return Container(
      child: Center(
        child: new ClipRect(
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
              new BackdropFilter(
                filter: new ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                child: new Text(text, style: style),
              ),
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: color,
        border: new Border(
          top: borderColor,
          left: borderColor,
          bottom: borderDarkColor,
          right: borderDarkColor,
        ),
      ),
    );
  }
}
