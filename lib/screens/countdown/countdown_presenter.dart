// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../../services/index.dart';
import '../../routes.dart';

abstract class CountdownScreenViewContract {
  void redirectTo(String route);
}

class CountdownScreenPresenter {
  CountdownScreenPresenter(this._view, this._animator);

  static const int countdownSeconds = 4;

  final Animator _animator;
  final CountdownScreenViewContract _view;

  void onLoad() {
    _animator.loadIntegerAnimation(
      begin: countdownSeconds,
      end: 0,
      onCompleted: () => _view.redirectTo(Routes.game),
    );
    _animator.forward(from: 0.0);
  }

  void dispose() {
    _animator.dispose();
  }
}
