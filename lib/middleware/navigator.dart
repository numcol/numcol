// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../domain/index.dart';

const routes = {
  Routes.home: "/",
  Routes.game: "game",
  Routes.countdown: "countdown",
  Routes.gameover: "gameover",
  Routes.settings: "settings",
};

abstract class NavigatorMixin<T extends StatefulWidget> extends State<T>
    implements NavigatorContract {
  factory NavigatorMixin._() => null;

  void navigateTo(Routes route) {
    Navigator.pushNamed(context, routes[route]);
  }

  void navigateToWithParameter(Routes route, dynamic parameter) {
    var path = routes[route] + '/' + parameter.toString();
    Navigator.pushNamed(context, path);
  }

  void redirectTo(Routes route) {
    Navigator.pushReplacementNamed(context, routes[route]);
  }

  void redirectToWithParameter(Routes route, dynamic parameter) {
    var path = routes[route] + '/' + parameter.toString();
    Navigator.pushReplacementNamed(context, path);
  }

  void navigateBack() {
    Navigator.pop(context);
  }
}
