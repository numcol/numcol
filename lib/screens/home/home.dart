// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart' hide Color;

import '../../domain/index.dart';
import '../../view/index.dart';
import '../../middleware/index.dart';
import 'home_presenter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with NavigatorMixin, MenuItemMixin
    implements HomeScreenViewContract {
  HomeScreenPresenter _homeScreenPresenter;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    var sharer = Injector.of(context).inject<Sharer>();
    _homeScreenPresenter = HomeScreenPresenter(this, sharer);
  }

  Widget _title() {
    return Container(
      padding: const EdgeInsets.only(bottom: 60.0),
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
              menuItem(Color.green, 'play',
                  _homeScreenPresenter.onPlayButtonPressed),
              menuItem(Color.yellow, 'kids_level',
                  _homeScreenPresenter.onKidsModeButtonPressed),
              menuItem(
                  Color.blue, 'rate', _homeScreenPresenter.onRateButtonPressed),
              menuItem(Color.red, 'settings',
                  _homeScreenPresenter.onSettingsButtonPressed),
            ],
          ),
        ),
      ),
    );
  }
}
