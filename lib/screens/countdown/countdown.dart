import 'package:flutter/material.dart';
import '../../routes.dart';
import 'widgets/index.dart';

class CountdownScreen extends StatefulWidget {
  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> with TickerProviderStateMixin {
  AnimationController _controller;

  static const int startValue = 4;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: startValue),
    );
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var animation = new StepTween(
      begin: startValue,
      end: 0,
    ).animate(_controller);
    animation.addStatusListener((animationStatus) {
      if (animationStatus == AnimationStatus.completed) {
        Navigator.popAndPushNamed(context, Routes.game);
      }
    });

    _controller.forward(from: 0.0);

    return new Scaffold(
      body: new Container(
        child: new Center(
          child: new CountdownWidget(
            animation: new StepTween(
              begin: startValue,
              end: 0,
            ).animate(_controller),
          ),
        ),
      ),
    );
  }
}
