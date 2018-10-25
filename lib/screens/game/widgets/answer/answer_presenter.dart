// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../../../../domain/index.dart';

abstract class AnswerViewContract {
  Answer get reply;
  void renew();
  void shake();
}

class AnswerPresenter {
  AnswerPresenter(this._view, this._game);

  final AnswerViewContract _view;
  final Game _game;

  void onPressed() {
    var isOk = _game.reply(_view.reply);
    if (isOk) {
      _view.renew();
    } else {
      _view.shake();
    }
  }
}
