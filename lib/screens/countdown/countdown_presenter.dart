// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../../domain/index.dart';

abstract class CountdownScreenViewContract implements NavigatorContract {}

class CountdownScreenPresenter {
  CountdownScreenPresenter(this._view, this._animator);

  final AnimatorContract _animator;
  final CountdownScreenViewContract _view;

  void onLoad() => _animator.forward();

  void onAnimationCompleted() => _view.redirectTo(Routes.game);
}
