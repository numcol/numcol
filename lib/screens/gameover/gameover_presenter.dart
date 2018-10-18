// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../../routes.dart';

abstract class GameoverScreenViewContract {
  void redirectTo(String route);
  void navigateBack();
}

class GameoverScreenPresenter {
  GameoverScreenPresenter(this._view);

  final GameoverScreenViewContract _view;

  void onTryAgainButtonClicked() {
    _view.redirectTo(Routes.countdown);
  }

  void onBackButtonClicked() {
    _view.navigateBack();
  }
}
