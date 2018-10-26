// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../../domain/index.dart';

abstract class HomeScreenViewContract implements NavigatorContract {}

class HomeScreenPresenter {
  HomeScreenPresenter(this._view, this._sharer);

  final HomeScreenViewContract _view;
  final SharerContract _sharer;

  void onPlayButtonPressed() {
    _view.navigateTo(Routes.countdown);
  }

  void onKidsModeButtonPressed() {
    _view.navigateToWithParameter(Routes.game, true);
  }

  void onRateButtonPressed() {
    _sharer.rateApp();
  }

  void onSettingsButtonPressed() {
    _view.navigateTo(Routes.settings);
  }
}
