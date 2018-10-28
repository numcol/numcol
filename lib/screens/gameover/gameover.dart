// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart' hide Color;

import '../../middleware/index.dart';
import '../../domain/index.dart';
import '../../view/index.dart';
import '../../i18n/index.dart';
import 'gameover_presenter.dart';

class GameoverScreen extends StatefulWidget {
  GameoverScreen({this.score});

  final int score;

  @override
  _GameoverScreenState createState() => _GameoverScreenState();
}

class _GameoverScreenState extends State<GameoverScreen>
    with NavigatorMixin, MenuItemMixin
    implements GameoverScreenViewContract {
  GameoverScreenPresenter _gameoverScreenPresenter;
  FirebaseAnalytics _analytics;
  int _topScore;
  bool _isNewTopScore = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final injector = Injector.of(context);
    _gameoverScreenPresenter = GameoverScreenPresenter(
        this, injector.inject<Storage>(), injector.inject<Sharer>());
    _gameoverScreenPresenter.onLoad(widget.score);
    _analytics = injector.inject<FirebaseAnalytics>();
  }

  Widget _numberTitle(String text) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
            fontFamily: Fonts.poiretone,
            fontSize: Responsive.getValue(context, 14.0, 24.0, 32.0),
            fontWeight: FontWeight.bold,
            color: ScreenColors.darkBlack),
      ),
      margin: EdgeInsets.only(
        bottom: 5.0,
      ),
      padding: const EdgeInsets.only(
        top: 3.0,
        bottom: 3.0,
        left: 10.0,
        right: 10.0,
      ),
      decoration: BoxDecoration(
        color: ScreenColors.lightGrey,
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
      ),
    );
  }

  Widget _number(String text, double fontSize) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
        ),
      ),
    );
  }

  List<Widget> _buildChildren() {
    var widgets = <Widget>[
      PageTitle(tag: 'gameover'),
    ];

    if (!_isNewTopScore) {
      widgets.add(_numberTitle(Translations.of(context).text('score')));
      widgets.add(_number(
        widget.score.toString(),
        Responsive.getValue(context, 54.0, 80.0, 108.0),
      ));
    }

    widgets.add(_numberTitle(Translations.of(context).text('high_score')));
    widgets.add(_number(
      _topScore.toString(),
      !_isNewTopScore
          ? Responsive.getValue(context, 32.0, 54.0, 72.0)
          : Responsive.getValue(context, 54.0, 80.0, 108.0),
    ));

    if (_isNewTopScore) {
      widgets.add(Congrats());
    }

    widgets.add(menuItem(Color.red, 'share', () {
      _analytics.logShare(
        contentType: 'score',
        itemId: widget.score.toString(),
      );
      _gameoverScreenPresenter.onShareButtonPressed(
        Translations.of(context).text('share_text'),
        widget.score,
      );
    }));
    widgets.add(menuItem(
      Color.green,
      'try_again',
      () => Ads.showOrContinue(
            _gameoverScreenPresenter.onTryAgainButtonPressed,
          ),
    ));
    widgets.add(menuItem(
      Color.blue,
      'back_to_menu',
      _gameoverScreenPresenter.onBackButtonPressed,
    ));

    return widgets;
  }

  void setTopScore(int topScore, bool isNew) {
    setState(() {
      _topScore = topScore;
      _isNewTopScore = isNew;
    });
  }

  void onTopscoreSavedError() {
    final snackBar = SnackBar(
      content: Text(Translations.of(context).text('savedError')),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Page(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _buildChildren(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
