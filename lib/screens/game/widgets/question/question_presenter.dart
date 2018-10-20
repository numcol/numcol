// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../../../../view/index.dart';

abstract class QuestionViewContract {
  bool get isColorOk;
  bool get isNumberOk;
}

class QuestionPresenter {
  QuestionPresenter(this._view, this._colorAnimator, this._numberAnimator);

  final QuestionAnimator _colorAnimator;
  final QuestionAnimator _numberAnimator;
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
}
