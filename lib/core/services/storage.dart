import 'package:shared_preferences/shared_preferences.dart';

const String _keyLanguage = "language";

class Storage {
  static Future<String> getLanguage() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage);
  }

  static Future<bool> setLanguage(String language) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setString(_keyLanguage, language);
  }
}
