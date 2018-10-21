// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

abstract class StorageContract {
  String getLanguage();
  Future<bool> setLanguage(String language);
  int getTopScore();
  Future<bool> setTopScore(int topScore);
  bool getIsAudioOn();
  Future<bool> setIsAudioOn(bool isAudioOn);
}
