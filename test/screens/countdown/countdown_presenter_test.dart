// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../../lib/routes.dart';
import '../../../lib/screens/countdown/countdown_presenter.dart';
import '../../../lib/services/index.dart';

class MockCountdownScreenView extends Mock implements CountdownScreenViewContract {}
class MockAnimator extends Mock implements Animator {}

void main() {
  MockCountdownScreenView _mockCountdownScreenView;
  MockAnimator _mockAnimator;
  CountdownScreenPresenter _countdownScreenPresenter;

  setUp(() async {
    _mockCountdownScreenView = MockCountdownScreenView();
    _mockAnimator = MockAnimator();
    _countdownScreenPresenter = CountdownScreenPresenter(_mockCountdownScreenView, _mockAnimator);
  });

  group('onLoad', () {
    test('Should run a 4 second countdown animation from the beginning', () {
      _countdownScreenPresenter.onLoad();
      verifyInOrder([
        _mockAnimator.loadIntegerAnimation(
          begin: 4,
          end: 0,
          onCompleted: anyNamed('onCompleted'),
        ),
        _mockAnimator.forward(from: 0.0),
      ]);
    });

    test('Should redirect to the game screen after the animation', () {
      _countdownScreenPresenter.onLoad();
      var onAnimationCompleted = verify(_mockAnimator.loadIntegerAnimation(
        begin: anyNamed('begin'),
        end: anyNamed('end'),
        onCompleted: captureAnyNamed('onCompleted'),
      )).captured.single;

      onAnimationCompleted();

      verify(_mockCountdownScreenView.redirectTo(Routes.game));
    });
  });

  group('dispose', () {
    test('Should dispose animator back', () {
      _countdownScreenPresenter.dispose();

      verify(_mockAnimator.dispose());
    });
  });
}
