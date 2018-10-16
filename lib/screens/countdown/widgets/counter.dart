import 'package:flutter/material.dart';

import '../../../styles.dart';

class CountdownWidget extends AnimatedWidget {
  CountdownWidget({ Key key, @required this.animation }) : super(key: key, listenable: animation);

  final Animation<int> animation;

  @override
  build(BuildContext context){
    return Container(
      height: 260.0,
      width: 260.0,
      child: Center(
        child: Text(
          animation.value == 0 ? 'Go!' : animation.value.toString(),
          style: new TextStyle(
            fontSize: 92.0,
            fontFamily: Fonts.poiretone
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: ScreenColors.lightGrey,
        borderRadius: BorderRadius.all(Radius.circular(130.0)),
      ),
    );
  }
}

