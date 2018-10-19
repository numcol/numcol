// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart' hide Color;

import '../../engine/index.dart';
import '../../i18n/index.dart';
import '../../view/index.dart';
import 'widgets/index.dart';
import 'settings_presenter.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with NavigatorMixin, MenuItemMixin
    implements SettingsScreenViewContract {

  SettingsScreenPresenter _settingsScreenPresenter;

  @override
  void initState() {
    super.initState();
    _settingsScreenPresenter = SettingsScreenPresenter(this);
  }

  Widget _buildTitle(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 60.0
        ),
        child: Text(
          Translations.of(context).text('settings').toUpperCase(),
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
      body: Builder(
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildTitle(context),
                  LanguageSwitcher(),
                  menuItem(Color.blue, 'back_to_menu', _settingsScreenPresenter.onBackButtonPressed),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
