import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart';
import 'widgets/index.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Answer> _answers = RandomGenerator.generateAnswers();
  Answer _question;

  @override
  Widget build(BuildContext context) {
    _question = RandomGenerator.generateQuestion(_answers);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              RemainingWidget(),
              ScoreWidget()
            ]
          ),
          QuestionWidget(_question),
          Expanded(child: AnswersWidget(_answers)),
        ]
      )
    );
  }
}
