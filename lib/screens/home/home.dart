// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart' hide Color;
import 'package:numcolengine/numcolengine.dart';

import '../../mixins/index.dart';
import '../../widgets/index.dart';
import '../../styles.dart';
import '../../i18n/index.dart';
import 'home_presenter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with NavigatorMixin
    implements HomeScreenViewContract {

  HomeScreenPresenter _homeScreenPresenter;

  @override
  initState() {
    super.initState();
    _homeScreenPresenter = new HomeScreenPresenter(this);
  }

  Widget _title() {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 60.0
      ),
      child: Text(
        'NumCol',
        style: TextStyle(
          fontSize: 72.0,
          color: ScreenColors.black,
          fontFamily: Fonts.poiretone,
        ),
      ),
    );
  }

  Widget _menuItem(Color color, String languageTag, NumcolButtonPressed command) {
    return MenuButton(
      color: color,
      text: Translations.of(context).text(languageTag),
      onPressed: command,
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
              Center(
                child: _title(),
              ),
              _menuItem(Color.green, 'play', _homeScreenPresenter.onPlayButtonClicked),
              _menuItem(Color.yellow, 'zen_mode', _homeScreenPresenter.onZenModeButtonClicked),
              _menuItem(Color.blue, 'top_score', _homeScreenPresenter.onTopScoreButtonClicked),
              _menuItem(Color.red, 'settings', _homeScreenPresenter.onSettingsButtonClicked),
            ],
          ),
        ),
      ),
    );
  }
}
