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

  void onPlayButtonClicked() {
    _view.navigateTo(Routes.countdown);
  }

  void onZenModeButtonClicked() {
    _view.navigateTo(Routes.countdown);
  }

  void onTopScoreButtonClicked() {
    _view.navigateTo(Routes.countdown);
  }

  void onSettingsButtonClicked() {
    _view.navigateTo(Routes.settings);
  }
}
