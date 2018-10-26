// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../../domain/index.dart';

abstract class GameScreenViewContract implements NavigatorContract {
  void updateView(Reply reply);
  void onGameOver(int score);
}

class GameScreenPresenter {
  GameScreenPresenter(this._view, this._game, this._audio);

  final Game _game;
  final GameScreenViewContract _view;
  final AudioPlayerContract _audio;

  List<Answer> get answers => _game.answers;
  Question get question => _game.question;
  int get score => _game.score;

  void onLoad(GameTimer timer, bool isZenMode) {
    _game.start(timer, isZenMode);
    _game.gameoverStream.listen((_) => _onGameOver());
    _game.replyStream.listen(_onReply);
  }

  void _onReply(Reply reply) {
    _view.updateView(reply);
    if (reply.isOk) {
      _audio.playClickSound();
    } else {
      _audio.playWrongSound();
    }
  }

  void _onGameOver() {
    _view.onGameOver(_game.score);
    _audio.playGameOverSound();
    _view.redirectToWithParameter(Routes.gameover, _game.score);
  }
}
