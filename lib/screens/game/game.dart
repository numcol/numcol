import 'package:flutter/material.dart';

import '../../configuration.dart';
import '../../services/index.dart';
import '../../domain/index.dart';
import '../../view/index.dart';
import 'widgets/index.dart';
import 'game_presenter.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with NavigatorMixin
    implements GameScreenViewContract {

  final ValueNotifier<Answer> _reply = ValueNotifier<Answer>(null);
  final ValueNotifier<bool> _isColorOk = ValueNotifier(true);
  final ValueNotifier<bool> _isNumberOk = ValueNotifier(true);
  final ValueNotifier<int> _score = ValueNotifier(0);
  List<ValueNotifier<Answer>> _answers;
  ValueNotifier<Answer> _question;

  GameScreenPresenter _presenter;
  Timer _timer;

  void _onAnswerPressed() {
    if (_reply.value != null) {
      var answer = _reply.value;
      var correctAnswerIndex = _presenter.onAnswerPressed(answer);
      if (correctAnswerIndex >= 0) {
        _answers[correctAnswerIndex].value = _presenter.answers[correctAnswerIndex];
        _question.value = _presenter.question;
        _score.value = _presenter.score;
      } else {
        _isColorOk.value = answer.color == _presenter.question.color;
        _isNumberOk.value = answer.number == _presenter.question.number;
      }
      _reply.value = null;
    }
  }

  void _gameover() {
    _presenter.onGameOver();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final configuration = Configuration.of(context);
    _timer = Injector.of(context).timerFactory.create(
      configuration.initialTimeInMilliseconds,
      configuration.timePenaltyMultiplier,
      configuration.timeAdditionByAnswerInMilliseconds,
      _gameover
    );
    _reply.addListener(_onAnswerPressed);
    _presenter = GameScreenPresenter(this, _timer, Game());
    _presenter.onLoad();
    _answers = _presenter.answers.map((answer) => ValueNotifier(answer)).toList();
    _question = ValueNotifier(_presenter.question);
  }

  List<Widget> _buildChildren() {
    return <Widget>[
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
      ProgressBarWidget(timer: _timer),
    ];
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
              children: _buildChildren(),
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
