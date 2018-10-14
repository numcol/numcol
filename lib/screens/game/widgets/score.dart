import 'package:flutter/material.dart';

class ScoreWidget extends StatefulWidget {
  ScoreWidget({Key key, @required this.score})
    : super(key: key);

  final ValueNotifier<int> score;

  @override
  _ScoreWidgetState createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {

  @override
  void initState() {
    super.initState();
    widget.score.addListener(() => setState(() => null));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Score'),
        Text(
          widget.score.value.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
