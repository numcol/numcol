// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

abstract class NavigatorMixin<T extends StatefulWidget> extends State<T> {
  factory NavigatorMixin._() => null;

  void navigateTo(String route) {
    Navigator.pushNamed(context, route);
  }

  void redirectTo(String route) {
    Navigator.pushReplacementNamed(context, route);
  }

  void navigateBack() {
    Navigator.pop(context);
  }
}
