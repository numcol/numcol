// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/index.dart';

const String _keyLanguage = "language";
const String _keyTopScore = "top_score";

class Storage implements StorageContract {
  Future<String> getLanguage() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage);
  }

  Future<bool> setLanguage(String language) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setString(_keyLanguage, language);
  }

  Future<int> getTopScore() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyTopScore);
  }

  Future<bool> setTopScore(int topScore) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_keyTopScore, topScore);
  }
}
