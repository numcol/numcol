// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart' hide Color;

import '../../../../domain/index.dart';
import '../../../../i18n/index.dart';
import '../../../../middleware/index.dart';
import '../../../../view/index.dart';
import 'audio_switcher_presenter.dart';

class AudioSwitcher extends StatefulWidget {
  @override
  _AudioSwitcherState createState() => _AudioSwitcherState();
}

class _AudioSwitcherState extends State<AudioSwitcher>
    implements AudioSwitcherViewContract {
  final GlobalKey<CustomExpansionTileState> expansionTile = GlobalKey();
  bool _isAudioOn = true;
  AudioSwitcherPresenter _presenter;
  FirebaseAnalytics _analytics;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _analytics = Injector.of(context).inject<FirebaseAnalytics>();
    _presenter = AudioSwitcherPresenter(
        this, Injector.of(context).inject<StorageContract>());
    _presenter.loadIsAudioOn();
  }

  void onLoadIsAudioOn(bool isAudioOn) {
    setState(() {
      _isAudioOn = isAudioOn;
    });
  }

  void onIsAudioOnSaved(bool isAudioOn) {
    _analytics.setUserProperty(
      name: 'audio',
      value: isAudioOn ? 'on' : 'off',
    );
    setState(() {
      _isAudioOn = isAudioOn;
    });
    _showSavedMessage();
  }

  void onIsAudioOnSavedError() {
    final snackBar = SnackBar(
      content: Text(Translations.of(context).text('savedError')),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _showSavedMessage() {
    final snackBar = SnackBar(
      content: Text(Translations.of(context).text('saved')),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210.0,
      child: Row(
        children: <Widget>[
          Text(
            Translations.of(context).text('sound'),
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Container(
            width: 160.0,
            child: Switch(
                value: _isAudioOn, onChanged: _presenter.onTogglePressed),
          ),
        ],
      ),
    );
  }
}
