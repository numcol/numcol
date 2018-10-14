import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart';

import 'widgets/reply.dart';
import 'widgets/index.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Game _game = new Game();
  final ValueNotifier<Answer> _reply = ValueNotifier<Answer>(null);
  final ValueNotifier<bool> _isColorOk = ValueNotifier(true);
  final ValueNotifier<bool> _isNumberOk = ValueNotifier(true);

  void _answerTaped (Answer answer) {
    if (answer != null) {
      if (_game.checkAnswer(answer)) {
        setState(() {
          _isColorOk.value = true;
          _isNumberOk.value = true;
          _game.nextQuestion(answer);
        });
      } else {
        setState(() {
          _isColorOk.value = answer.color == _game.question.color;
          _isNumberOk.value = answer.number == _game.question.number;
        });
        setState(() {
          _isColorOk.value = true;
          _isNumberOk.value = true;
        });
      }
      _reply.value = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _reply.addListener(() => _answerTaped(_reply.value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReplyInheritedWidget(
        reply: _reply,
        child: SafeArea(
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
                QuestionWidget(
                  question: _game.question,
                  isColorOk: _isColorOk,
                  isNumberOk: _isNumberOk
                ),
                Expanded(
                  child: AnswersWidget(
                    answers: _game.answers
                  ),
                ),
              ]
            )
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    _reply.dispose();
    super.dispose();
  }
}
