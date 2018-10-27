// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../configuration.dart';
import '../../view/index.dart';
import '../../middleware/index.dart';
import 'widgets/index.dart';
import 'countdown_presenter.dart';

class CountdownScreen extends StatefulWidget {
  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen>
    with TickerProviderStateMixin, NavigatorMixin
    implements CountdownScreenViewContract {
  CountdownScreenPresenter _presenter;
  CountdownAnimator _animator;

  void _onAnimationComplete() {
    _presenter.onAnimationCompleted();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final configuration = Configuration.of(context);
    final audio = Injector.of(context).inject<AudioPlayer>();
    _animator =
        Injector.of(context).inject<AnimatorFactory>().createCountdownAnimator(
              vsync: this,
              seconds: configuration.gameStartCountdownSeconds,
              begin: configuration.gameStartCountdownSeconds,
              end: 0,
              onCompleted: _onAnimationComplete,
            );
    _presenter = CountdownScreenPresenter(this, _animator, audio);
    _presenter.onLoad();
  }

  @override
  void dispose() {
    _animator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Page(
        child: Center(
          child: CountdownWidget(
            animation: _animator.animation,
          ),
        ),
      ),
    );
  }
}
