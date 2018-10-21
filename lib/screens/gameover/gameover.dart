// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart' hide Color;

import '../../services/index.dart';
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
  int _topScore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _gameoverScreenPresenter = GameoverScreenPresenter(
      this,
      Injector.of(context).inject<Storage>(),
      Injector.of(context).inject<Sharer>());
    _gameoverScreenPresenter.onLoad(widget.score);
  }

  Widget _title() {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 60.0
        ),
        child: Text(
          Translations.of(context).text('gameover').toUpperCase(),
          style: TextStyle(
            fontSize: 42.0,
            color: ScreenColors.black,
            fontFamily: Fonts.poiretone,
          ),
        ),
      ),
    );
  }

  void setTopScore(int topScore, bool isNew) {
    setState(() {
      _topScore = topScore;
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
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _title(),
              Text('Top Score: ' + _topScore.toString()),
              Text('Score: ' + widget.score.toString()),
              menuItem(Color.red, 'share', () => _gameoverScreenPresenter.onShareButtonPressed(
                Translations.of(context).text('share_text'),
                widget.score,
              )),
              menuItem(Color.green, 'try_again', _gameoverScreenPresenter.onTryAgainButtonPressed),
              menuItem(Color.blue, 'back_to_menu', _gameoverScreenPresenter.onBackButtonPressed),
            ],
          ),
        ),
      ),
    );
  }
}
