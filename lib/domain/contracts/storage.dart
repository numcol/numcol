// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

abstract class StorageContract {
  Future<String> getLanguage();
  Future<bool> setLanguage(String language);
  Future<int> getTopScore();
  Future<bool> setTopScore(int topScore);
}
