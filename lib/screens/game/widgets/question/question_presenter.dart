// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../../../../domain/index.dart';

abstract class QuestionViewContract {
  bool get isColorOk;
  bool get isNumberOk;
  set isColorOk(bool isOk);
  set isNumberOk(bool isOk);
}

class QuestionPresenter {
  QuestionPresenter(this._view, this._colorAnimator, this._numberAnimator);

  final AnimatorContract _colorAnimator;
  final AnimatorContract _numberAnimator;
  final QuestionViewContract _view;

  void onIsColorOkValueChanged() {
    if (!_view.isColorOk) {
      _colorAnimator.forward();
    }
  }

  void onIsNumberOkValueChanged() {
    if (!_view.isNumberOk) {
      _numberAnimator.forward();
    }
  }

  void onIsColorAnimationCompleted() {
    _colorAnimator.reverse();
  }

  void onIsNumberAnimationCompleted() {
    _numberAnimator.reverse();
  }

  void onIsColorAnimationDismissed() {
    _colorAnimator.stop();
    _view.isColorOk = true;
  }

  void onIsNumberAnimationDismissed() {
    _numberAnimator.stop();
    _view.isNumberOk = true;
  }
}
