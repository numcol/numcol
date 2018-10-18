// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'animator.dart';
import 'storage.dart';

class Injector extends StatelessWidget {
  const Injector({
    Key key,
    @required this.storage,
    @required this.animatorFactory,
    @required this.child})
      : super(key: key);

  static _InheritedInjector of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(_InheritedInjector);
  }

  final Storage storage;
  final AnimatorFactory animatorFactory;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new _InheritedInjector(
      storage: storage,
      animatorFactory: animatorFactory,
      child: child,
    );
  }
}

class _InheritedInjector extends InheritedWidget {
  _InheritedInjector({
    Key key,
    @required this.storage,
    @required this.animatorFactory,
    @required child})
      : super(key: key, child: child);

  final Storage storage;
  final AnimatorFactory animatorFactory;

  @override
  bool updateShouldNotify(_InheritedInjector oldWidget) {
    return false;
  }
}
