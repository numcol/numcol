// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/index.dart';

const String _keyLanguage = 'language';
const String _keyTopScore = 'top_score';
const String _keyIsAudioOn = 'audio_on';

class Storage implements StorageContract {
  const Storage(this._preferences);

  final SharedPreferences _preferences;

  String getLanguage() {
    return _preferences.getString(_keyLanguage);
  }

  Future<bool> setLanguage(String language) {
    return _preferences.setString(_keyLanguage, language);
  }

  int getTopScore() {
    return _preferences.getInt(_keyTopScore) ?? 0;
  }

  Future<bool> setTopScore(int topScore) {
    return _preferences.setInt(_keyTopScore, topScore);
  }

  bool getIsAudioOn() {
    return _preferences.getBool(_keyIsAudioOn) ?? true;
  }

  Future<bool> setIsAudioOn(bool isAudioOn) {
    return _preferences.setBool(_keyIsAudioOn, isAudioOn);
  }
}
