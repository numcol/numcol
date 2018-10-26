// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class Injector extends StatelessWidget {
  const Injector({Key key, @required this.dependencies, @required this.child})
      : super(key: key);

  static _InheritedInjector of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(_InheritedInjector);
  }

  final List<dynamic> dependencies;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _InheritedInjector(
      dependencies: dependencies,
      child: child,
    );
  }
}

class _InheritedInjector extends InheritedWidget {
  _InheritedInjector({Key key, @required this.dependencies, @required child})
      : super(key: key, child: child);

  final List<dynamic> dependencies;

  T inject<T>() {
    return dependencies.firstWhere((object) => object is T);
  }

  @override
  bool updateShouldNotify(_InheritedInjector oldWidget) {
    return false;
  }
}
