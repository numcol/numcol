// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../../lib/domain/index.dart';
import '../../../lib/services/index.dart';
import '../../../lib/screens/countdown/countdown_presenter.dart';

class MockCountdownScreenView extends Mock implements CountdownScreenViewContract {}
class MockAudioPlayer extends Mock implements AudioPlayer {}
class MockAnimator extends Mock implements AnimatorContract {}

void main() {
  MockCountdownScreenView _mockCountdownScreenView;
  MockAnimator _mockAnimator;
  MockAudioPlayer _mockAudio;
  CountdownScreenPresenter _countdownScreenPresenter;

  setUp(() async {
    _mockCountdownScreenView = MockCountdownScreenView();
    _mockAnimator = MockAnimator();
    _mockAudio = MockAudioPlayer();
    _countdownScreenPresenter = CountdownScreenPresenter(_mockCountdownScreenView, _mockAnimator, _mockAudio);
  });

  group('Countdown Screen:', () {
    group('On load', () {
      test('it starts the countdown animation', () {
        _countdownScreenPresenter.onLoad();

        verify(_mockAnimator.forward());
      });
    });

    group('On animation completed', () {
      test('it redirects to the game screen', () {
        _countdownScreenPresenter.onAnimationCompleted();

        verify(_mockCountdownScreenView.redirectTo(Routes.game));
      });

      test('it plays the game start sound', () {
        _countdownScreenPresenter.onAnimationCompleted();
        verify(_mockAudio.playStartSound());
      });
    });
  });
}
