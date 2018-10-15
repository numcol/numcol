import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart';

import '../../routes.dart';
import '../../application.dart';
import '../../core/index.dart';
import 'widgets/reply.dart';
import 'widgets/index.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Game _game = new Game();
  final ValueNotifier<Answer> _reply = ValueNotifier<Answer>(null);
  final ValueNotifier<bool> _isColorOk = ValueNotifier(true);
  final ValueNotifier<bool> _isNumberOk = ValueNotifier(true);
  final ValueNotifier<int> _score = ValueNotifier(0);

  Timer _timer;
  List<ValueNotifier<Answer>> _answers;
  ValueNotifier<Answer> _question;

  void _answerTaped (Answer answer) {
    if (answer != null) {
      if (_game.checkAnswer(answer)) {
        var answerIndex = _game.nextQuestion(answer, _timer.remainingInMilliseconds, _timer.maxTimeInMilliseconds);
        _timer.success();

        _answers[answerIndex].value = _game.answers[answerIndex];
        _question.value = _game.question;
        _score.value = _game.score;
      } else {
        _isColorOk.value = answer.color == _game.question.color;
        _isNumberOk.value = answer.number == _game.question.number;
        var isGameOver = _timer.fail();
        if (isGameOver) {
          _gameover();
        }
      }
      _reply.value = null;
    }
  }

  void _gameover() {
    Navigator.popAndPushNamed(context, Routes.gameover);
  }

  @override
  void initState() {
    super.initState();
    _reply.addListener(() => _answerTaped(_reply.value));
    _answers = _game.answers.map((answer) => ValueNotifier(answer)).toList();
    _question = ValueNotifier(_game.question);
    _timer = new Timer(
      application.initialTimeInMilliseconds,
      application.timePenaltyMultiplier,
      application.timeAdditionByAnswerInMilliseconds,
      _gameover
    );
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
                    RemainingWidget(timer: _timer),
                    ScoreWidget(score: _score)
                  ]
                ),
                QuestionWidget(
                  question: _question,
                  isColorOk: _isColorOk,
                  isNumberOk: _isNumberOk
                ),
                Expanded(
                  child: AnswersWidget(
                    answers: _answers,
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
    _timer.dispose();
    _reply.dispose();
    _isColorOk.dispose();
    _isNumberOk.dispose();
    _question.dispose();
    _answers.forEach((answer) => answer.dispose());
    super.dispose();
  }
}
