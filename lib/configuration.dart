// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class Configuration extends StatelessWidget {
  const Configuration({
    Key key,
    @required this.child,
    @required this.initialTimeInMilliseconds,
    @required this.timePenaltyMultiplier,
    @required this.timeAdditionByAnswerInMilliseconds,
    @required this.gameStartCountdownSeconds})
      : super(key: key);

  static _InheritedConfiguration of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(_InheritedConfiguration);
  }

  final Widget child;
  final int initialTimeInMilliseconds;
  final double timePenaltyMultiplier;
  final int timeAdditionByAnswerInMilliseconds;
  final int gameStartCountdownSeconds;

  @override
  Widget build(BuildContext context) {
    return _InheritedConfiguration(
      child: child,
      initialTimeInMilliseconds: initialTimeInMilliseconds,
      timePenaltyMultiplier: timePenaltyMultiplier,
      timeAdditionByAnswerInMilliseconds: timeAdditionByAnswerInMilliseconds,
      gameStartCountdownSeconds: gameStartCountdownSeconds,
    );
  }
}

class _InheritedConfiguration extends InheritedWidget {
  _InheritedConfiguration({
    Key key,
    @required child,
    @required this.initialTimeInMilliseconds,
    @required this.timePenaltyMultiplier,
    @required this.timeAdditionByAnswerInMilliseconds,
    @required this.gameStartCountdownSeconds})
      : super(key: key, child: child);

  final int initialTimeInMilliseconds;
  final double timePenaltyMultiplier;
  final int timeAdditionByAnswerInMilliseconds;
  final int gameStartCountdownSeconds;

  @override
  bool updateShouldNotify(_InheritedConfiguration oldWidget) {
    return false;
  }
}
