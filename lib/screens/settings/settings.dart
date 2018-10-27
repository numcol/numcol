// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart' hide Color;

import '../../domain/index.dart';
import '../../view/index.dart';
import '../../middleware/index.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Page(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                PageTitle(tag: 'settings'),
                AudioSwitcher(),
                LanguageSwitcher(),
                menuItem(Color.blue, 'back_to_menu',
                    _settingsScreenPresenter.onBackButtonPressed),
              ],
            ),
          );
        },
      ),
    );
  }
}
