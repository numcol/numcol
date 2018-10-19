// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart' hide Color;

import '../../engine/index.dart';
import '../../view/index.dart';
import '../../i18n/index.dart';
import 'gameover_presenter.dart';

class GameoverScreen extends StatefulWidget {
  @override
  _GameoverScreenState createState() => _GameoverScreenState();
}

class _GameoverScreenState extends State<GameoverScreen>
    with NavigatorMixin, MenuItemMixin
    implements GameoverScreenViewContract {

  GameoverScreenPresenter _gameoverScreenPresenter;

  @override
  void initState() {
    super.initState();
    _gameoverScreenPresenter = GameoverScreenPresenter(this);
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
              menuItem(Color.green, 'try_again', _gameoverScreenPresenter.onTryAgainButtonPressed),
              menuItem(Color.blue, 'back_to_menu', _gameoverScreenPresenter.onBackButtonPressed),
            ],
          ),
        ),
      ),
    );
  }
}
