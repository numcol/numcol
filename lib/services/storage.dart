// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:shared_preferences/shared_preferences.dart';

const String _keyLanguage = "language";

class Storage {
  Future<String> getLanguage() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage);
  }

  Future<bool> setLanguage(String language) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setString(_keyLanguage, language);
  }
}
