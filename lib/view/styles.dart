import 'package:flutter/material.dart';

import '../domain/index.dart' as Engine;

class ScreenColors {
  static const red = const Color(0xffff4545);
  static const darkRed = const Color(0xffda2727);
  static const green = const Color(0xff83ec3a);
  static const darkGreen = const Color(0xff61ce14);
  static const yellow = const Color(0xffffef39);
  static const darkYellow = const Color(0xffe6d413);
  static const blue = const Color(0xff31ceff);
  static const darkBlue = const Color(0xff16a8d4);
  static const black = const Color(0xff444444);
  static const darkBlack = const Color(0xff333333);
  static const white = const Color(0xffffffff);
  static const lightGrey = const Color(0xffeeeeee);
}

class Fonts {
  static const poiretone = 'Poiretone';
  static const lemonMilk = 'LemonMilk';
  static const robotoMono = 'RobotoMono';
}

var colors = {
  Engine.Color.blue: ScreenColors.blue,
  Engine.Color.red: ScreenColors.red,
  Engine.Color.green: ScreenColors.green,
  Engine.Color.yellow: ScreenColors.yellow,
};

var darkColors = {
  Engine.Color.blue: ScreenColors.darkBlue,
  Engine.Color.red: ScreenColors.darkRed,
  Engine.Color.green: ScreenColors.darkGreen,
  Engine.Color.yellow: ScreenColors.darkYellow,
};
