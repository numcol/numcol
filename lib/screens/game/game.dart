import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../../configuration.dart';
import '../../middleware/index.dart';
import '../../domain/index.dart';
import '../../view/index.dart';
import 'widgets/index.dart';
import 'game_presenter.dart';

class GameScreen extends StatefulWidget {
  GameScreen({this.isZenMode});

  final bool isZenMode;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with NavigatorMixin, TickerProviderStateMixin
    implements GameScreenViewContract {
  ValueNotifier<int> _score;
  List<ValueNotifier<Answer>> _answers;
  ValueNotifier<Question> _question;

  GameScreenPresenter _presenter;
  GameTimerAnimator _animator;
  FirebaseAnalytics _analytics;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final configuration = Configuration.of(context);
    var audio = Injector.of(context).inject<AudioPlayer>();
    var game = Injector.of(context).inject<Game>();
    _analytics = Injector.of(context).inject<FirebaseAnalytics>();
    _animator =
        Injector.of(context).inject<AnimatorFactory>().createGameAnimator(
              vsync: this,
              milliseconds: configuration.initialTimeInMilliseconds,
            );
    var timer = GameTimer(
        _animator,
        configuration.initialTimeInMilliseconds,
        configuration.timeReducerMultiplier,
        configuration.timePenaltyMultiplier,
        configuration.timeAdditionByAnswerInMilliseconds);
    _presenter = GameScreenPresenter(this, game, audio);
    _presenter.onLoad(timer, widget.isZenMode);
    _answers =
        _presenter.answers.map((answer) => ValueNotifier(answer)).toList();
    _question = ValueNotifier(_presenter.question);
    _score = ValueNotifier(_presenter.score);
  }

  void updateView(Reply reply) {
    if (reply.isOk) {
      _answers[reply.answer.id].value = _presenter.answers[reply.answer.id];
      _question.value = _presenter.question;
      _score.value = _presenter.score;
    }
  }

  List<Widget> _buildHeader() {
    var widgets = <Widget>[
      ScoreWidget(score: _score),
    ];

    if (!widget.isZenMode) {
      widgets.insert(0, RemainingWidget(animation: _remainingAnimation()));
    }

    return widgets;
  }

  List<Widget> _buildChildren() {
    return <Widget>[
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buildHeader()),
      QuestionWidget(
        question: _question,
      ),
      Expanded(
        child: AnswersWidget(
          answers: _answers,
        ),
      ),
      ProgressBarWidget(animator: _animator),
    ];
  }

  Animation _remainingAnimation() {
    return StepTween(
      begin: _animator.maxTimeInMilliseconds.round(),
      end: 0,
    ).animate(_animator.animation);
  }

  @override
  void onGameOver(int score) {
    _analytics.logPostScore(score: score, level: widget.isZenMode ? 0 : 1);
  }

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
            children: _buildChildren(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animator.dispose();
    _question.dispose();
    _answers.forEach((answer) => answer.dispose());
    super.dispose();
  }
}
