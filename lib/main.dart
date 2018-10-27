// NumCol - The Brain Training Game About Matching Numbers And Colours.
// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'dart:async';

import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'configuration.dart';
import 'numcol.dart';
import 'middleware/index.dart';
import 'domain/index.dart';
import 'view/index.dart';

void main() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  var isDebugMode = false;
  assert(() {
    isDebugMode = true;
    return true;
  }());

  FlutterError.onError = (FlutterErrorDetails details) {
    if (isDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  await FlutterCrashlytics().initialize();

  runZoned<Future<Null>>(() async {
    runApp(FutureBuilder<RemoteConfig>(
      future: setupRemoteConfig(isDebugMode),
      builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
        final audioCache = AudioCache(prefix: 'audio/');
        final storage = Storage(sharedPreferences);
        final remoteConfig = snapshot.data;

        return snapshot.hasData
            ? Configuration(
                initialTimeInMilliseconds:
                    remoteConfig.getInt('initialTimeInMilliseconds'),
                timeReducerMultiplier:
                    remoteConfig.getDouble('timeReducerMultiplier'),
                timePenaltyMultiplier:
                    remoteConfig.getDouble('timePenaltyMultiplier'),
                timeAdditionByAnswerInMilliseconds:
                    remoteConfig.getInt('timeAdditionByAnswerInMilliseconds'),
                gameStartCountdownSeconds:
                    remoteConfig.getInt('gameStartCountdownSeconds'),
                zenModePoints: remoteConfig.getInt('zenModePoints'),
                child: Injector(
                  dependencies: [
                    storage,
                    AnimatorFactory(),
                    AudioPlayer(storage, audioCache),
                    Sharer(),
                    FirebaseAnalytics(),
                    Game(remoteConfig.getInt('zenModePoints')),
                  ],
                  child: NumcolApp(),
                ),
              )
            : Container();
      },
    ));
  }, onError: (error, stackTrace) async {
    await FlutterCrashlytics()
        .reportCrash(error, stackTrace, forceCrash: false);
  });
}

Future<RemoteConfig> setupRemoteConfig(bool isDebugMode) async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: isDebugMode));
  remoteConfig.setDefaults(<String, dynamic>{
    'initialTimeInMilliseconds': 10000,
    'timeReducerMultiplier': 0.99,
    'timePenaltyMultiplier': 0.66,
    'timeAdditionByAnswerInMilliseconds': 1800,
    'gameStartCountdownSeconds': 4,
    'zenModePoints': 10,
  });
  return remoteConfig;
}
