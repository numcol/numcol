// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../../routes.dart';

abstract class HomeScreenViewContract {
  void navigateTo(String route);
}

class HomeScreenPresenter {
  HomeScreenPresenter(this._view);

  final HomeScreenViewContract _view;

  void onPlayButtonPressed() {
    _view.navigateTo(Routes.countdown);
  }

  void onZenModeButtonPressed() {
    _view.navigateTo(Routes.countdown);
  }

  void onTopScoreButtonPressed() {
    _view.navigateTo(Routes.countdown);
  }

  void onSettingsButtonPressed() {
    _view.navigateTo(Routes.settings);
  }
}
