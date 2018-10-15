import 'package:flutter/material.dart';

import '../../../../styles.dart';

class RemainingCounter extends AnimatedWidget {
  RemainingCounter({ Key key, @required this.animation }) : super(key: key, listenable: animation);

  final Animation<int> animation;

  @override
  build(BuildContext context){
    return new Text(
      (animation.value / 1000).toStringAsFixed(3).padLeft(6, '0'),
      style: TextStyle(
        fontFamily: Fonts.robotoMono,
      ),
    );
  }
}
