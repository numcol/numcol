// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../mixins/index.dart';
import '../../services/index.dart';
import 'widgets/index.dart';
import 'countdown_presenter.dart';

class CountdownScreen extends StatefulWidget {
  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen>
    with TickerProviderStateMixin, NavigatorMixin
    implements CountdownScreenViewContract {

  static const int countdownSeconds = 4;

  CountdownScreenPresenter _presenter;
  Animator _animator;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animator = Injector.of(context).animatorFactory.create(this, countdownSeconds);
    _presenter = CountdownScreenPresenter(this, _animator);
    _presenter.onLoad();
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Center(
          child: new CountdownWidget(
            animation: _animator.animation,
          ),
        ),
      ),
    );
  }
}
