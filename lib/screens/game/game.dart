import 'package:flutter/material.dart';
import '../../services/game_service.dart';
import '../../model/answer.dart';
import 'widgets/index.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Answer> _answers = GameService.newGameData();
  Answer _question;

  @override
  Widget build(BuildContext context) {
    _question = GameService.getRandomQuestion(_answers);
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
