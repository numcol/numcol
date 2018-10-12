import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart';
import 'widgets/index.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Game _game = new Game();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RemainingWidget(),
                  ScoreWidget()
                ]
              ),
              QuestionWidget(_game.question),
              Expanded(child: AnswersWidget(_game.answers)),
            ]
          )
        )
      )
    );
  }
}
