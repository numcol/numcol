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

import 'package:audioplayers/audio_cache.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'configuration.dart';
import 'numcol.dart';
import 'services/index.dart';
import 'domain/index.dart';

void main() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final audioCache = AudioCache(prefix: 'audio/');
  final storage = Storage(sharedPreferences);
  final animatorFactory = AnimatorFactory();
  final sharer = Sharer();
  final analytics = FirebaseAnalytics();
  final audio = AudioPlayer(storage, audioCache);
  final game = Game();

  runApp(
    Configuration(
      initialTimeInMilliseconds: 10000,
      timePenaltyMultiplier: 0.66,
      timeAdditionByAnswerInMilliseconds: 1800,
      gameStartCountdownSeconds: 4,
      child: Injector(
        dependencies: [
          storage,
          animatorFactory,
          audio,
          sharer,
          analytics,
          game,
        ],
        child: NumcolApp(),
      ),
    ),
  );
}
