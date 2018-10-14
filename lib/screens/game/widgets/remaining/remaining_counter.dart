import 'package:flutter/material.dart';

class RemainingCounter extends AnimatedWidget {
  RemainingCounter({ Key key, @required this.animation }) : super(key: key, listenable: animation);

  final Animation<int> animation;

  @override
  build(BuildContext context){
    return new Text(
      animation.value.toString(),
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
