// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'storage.dart';

class Injector extends StatelessWidget {
  const Injector({Key key, @required this.storage, @required this.child})
      : super(key: key);

  static _InheritedInjector of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(_InheritedInjector);
  }

  final Storage storage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new _InheritedInjector(
      storage: storage,
      child: child,
    );
  }
}

class _InheritedInjector extends InheritedWidget {
  _InheritedInjector({Key key, @required this.storage, @required child})
      : super(key: key, child: child);

  final Storage storage;

  @override
  bool updateShouldNotify(_InheritedInjector oldWidget) {
    return false;
  }
}
