// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../collections/index.dart';

abstract class NavigatorContract {
  void navigateTo(Routes route);
  void navigateToWithParameter(Routes route, dynamic parameter);
  void redirectTo(Routes route);
  void redirectToWithParameter(Routes route, dynamic parameter);
  void navigateBack();
}
