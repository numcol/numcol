// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'dart:math';

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../lib/domain/index.dart';

class MockTimer extends Mock implements Timer {}

void main() {
  const initialTimeInMilliseconds = 10000;
  const timePenaltyMultiplier = 0.66;
  const timeAdditionByAnswerInMilliseconds = 1800;

  MockTimer _mockInternalTimer;
  GameTimer _gameTimer;

  setUp(() async {
    _mockInternalTimer = MockTimer();
    _gameTimer = GameTimer(
      _mockInternalTimer,
      initialTimeInMilliseconds,
      timePenaltyMultiplier,
      timeAdditionByAnswerInMilliseconds);
  });

  group('Game Timer:', () {
    group('On get timer', () {
      test('it returns internal timer', () {
        expect(_gameTimer.timer, _mockInternalTimer);
      });
    });

    group('On get max time', () {
      test('it returns the initial time when the timer started after last answer', () {
        when(_mockInternalTimer.maxTimeInMilliseconds)
          .thenReturn(10000);
        expect(_gameTimer.maxTimeInMilliseconds, 10000);
      });
    });

    group('On start', () {
      test('it starts the timer with the initialy set milliseconds', () {
        _gameTimer.start();
        verify(_mockInternalTimer.start(initialTimeInMilliseconds));
      });
    });

    group('On success', () {
      test('it adds extra time (as configured)', () {
        when(_mockInternalTimer.maxTimeInMilliseconds)
          .thenReturn(10000);
        when(_mockInternalTimer.elapsedInMilliseconds)
          .thenReturn(2000);

        _gameTimer.success();

        verify(_mockInternalTimer.start(10000 - 2000 + timeAdditionByAnswerInMilliseconds));
      });
    });

    group('On fail', () {
      test('it reduces the time (multiplying remaining time by the penalty factor)', () {
        when(_mockInternalTimer.maxTimeInMilliseconds)
          .thenReturn(10000);
        when(_mockInternalTimer.elapsedInMilliseconds)
          .thenReturn(2000);

        _gameTimer.fail();

        verify(_mockInternalTimer.start(((10000 - 2000) * timePenaltyMultiplier).ceil()));
      });

      test('it triggers game over if the time is reachs zero', () {
        when(_mockInternalTimer.maxTimeInMilliseconds)
          .thenReturn(10000);
        when(_mockInternalTimer.elapsedInMilliseconds)
          .thenReturn(10000);

        var isGameover = _gameTimer.fail();

        expect(isGameover, true);
      });

      test('it does not trigger game over if the time is over zero', () {
        when(_mockInternalTimer.maxTimeInMilliseconds)
          .thenReturn(10000);
        when(_mockInternalTimer.elapsedInMilliseconds)
          .thenReturn(5000);

        var isGameover = _gameTimer.fail();

        expect(isGameover, false);
      });
    });
  });
}
