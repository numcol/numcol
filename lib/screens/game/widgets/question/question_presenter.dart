// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../../../../domain/index.dart';

abstract class QuestionViewContract {
  AnimatorContract get colorAnimator;
  AnimatorContract get numberAnimator;
  Question get question;
}

class QuestionPresenter {
  QuestionPresenter(this._view);

  final QuestionViewContract _view;

  void onReply(Reply reply) {
    if (!reply.isOk) {
      if (reply.answer.color != _view.question.color) {
        _view.colorAnimator.forward();
      }
      if (reply.answer.number != _view.question.number) {
        _view.numberAnimator.forward();
      }
    }
  }
}
