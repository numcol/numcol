// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../../domain/index.dart';

abstract class GameoverScreenViewContract implements NavigatorContract {
  void setTopScore(int topScore, bool isNew);
  void onTopscoreSavedError();
}

class GameoverScreenPresenter {
  GameoverScreenPresenter(this._view, this._storage, this._sharer);

  final GameoverScreenViewContract _view;
  final StorageContract _storage;
  final SharerContract _sharer;

  int topScore;

  void onLoad(int score) {
    var topScore = _storage.getTopScore();
    if (topScore == null || score > topScore) {
      _storage.setTopScore(score).then((isSaved) {
        if (!isSaved) {
          _view.onTopscoreSavedError();
        }
      });
      _view.setTopScore(score, true);
    } else {
      _view.setTopScore(topScore, false);
    }
  }

  void onShareButtonPressed(String text, int score) {
    _sharer.shareScore(text, score);
  }

  void onTryAgainButtonPressed() {
    _view.redirectTo(Routes.countdown);
  }

  void onBackButtonPressed() {
    _view.navigateBack();
  }
}
