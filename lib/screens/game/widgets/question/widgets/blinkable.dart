import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart';

import '../../reply.dart';
import '../../../../../styles.dart';

class Blinkable extends StatefulWidget {
  Blinkable(this.answers);

  final List<Answer> answers;

  @override
  _BlinkableState createState() => _BlinkableState();
}

class _BlinkableState extends State<Blinkable> with TickerProviderStateMixin {
  final Tween colorTween = ColorTween(begin: ScreenColors.black, end: ScreenColors.darkRed);
  AnimationController _controller;
  Animation _color;

  void _blinkIfError() {
    var reply = ReplyInheritedWidget.of(context).reply;
    if (reply.value != null) {
      print(reply.value.color.toString() + ' ' + reply.value.number.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 1)
    );
    _color = colorTween.animate(_controller)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    })..addListener(() {
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    ReplyInheritedWidget.of(context).reply.addListener(_blinkIfError);
    _controller.forward();
    return Text(
      "Text button",
      style: TextStyle(
        color: _color.value
      ),
    );
  }

  @override
  void dispose() {
    ReplyInheritedWidget.of(context).reply.removeListener(_blinkIfError);
    _controller.dispose();
    super.dispose();
  }
}
