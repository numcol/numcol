import 'package:flutter/material.dart';

class CountdownWidget extends AnimatedWidget {
  CountdownWidget({ Key key, this.animation }) : super(key: key, listenable: animation);

  final Animation<int> animation;

  @override
  build(BuildContext context){
    return new Text(
      animation.value.toString(),
      style: new TextStyle(fontSize: 150.0),
    );
  }
}

