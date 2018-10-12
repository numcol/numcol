import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  ScoreWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Score'),
        Text('1234')
      ]
    );
  }
}
