// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../lib/domain/index.dart';

class MockTimer extends Mock implements GameTimer {}

void main() {

  Game _game;
  MockTimer _mockTimer;
  StreamController _gameoverStreamer;

  const int zenModePoints = 10;

  group('Game:', () {

    setUp(() async {
      _mockTimer = MockTimer();
      _game = Game(zenModePoints);
      _gameoverStreamer = StreamController.broadcast();
      when(_mockTimer.gameoverStream)
        .thenAnswer((_) => _gameoverStreamer.stream);
    });

    group('On game start', () {
      test('it has 36 possible answers', () {
        _game.start(_mockTimer, true);
        expect(_game.answers.length, 36);
      });

      test('it has an answerable question', () {
        _game.start(_mockTimer, false);
        expect(_game.answers.any((a) => a.color == _game.question.color && a.number == _game.question.number), true);
      });

      test('it starts with 0 score', () {
        _game.start(_mockTimer, false);
        expect(_game.score, 0);
      });

      test('it ensures the timer will trigger gameover on timer end', () {
        var completer = Completer<bool>();

        _game.start(_mockTimer, false);
        _game.gameoverStream.listen((_) => completer.complete(true));
        _gameoverStreamer.add(null);

        expect(completer.future, completion(true));
      });

      test('it starts the timer', () {
        _game.start(_mockTimer, false);
        verify(_mockTimer.start());
      });
    });

    group('When replying', () {
      group('if the answer is right', () {
        Answer correctAnswer;

        setUp(() async {
          _game.start(_mockTimer, false);
          correctAnswer = _game.answers.firstWhere(
            (answer) => answer.number == _game.question.number && answer.color == _game.question.color
          );
          when(_mockTimer.maxTimeInMilliseconds)
            .thenReturn(1000);
          when(_mockTimer.remainingInMilliseconds)
            .thenReturn(500);
        });

        test('it returns true', () {
          expect(_game.reply(correctAnswer), true);
        });

        test('it adds extra time to the timer', () {
          _game.reply(correctAnswer);
          verify(_mockTimer.success(0));
        });

        test('it renews the question', () {
          var oldQuestion = _game.question;
          _game.reply(correctAnswer);
          expect(oldQuestion != _game.question, true);
        });

        test('it replace the answer with a new one', () {
          _game.reply(correctAnswer);
          expect(_game.answers[correctAnswer.id] != correctAnswer, true);
        });

        test('it adds score based on the remaining time from the last answer', () {
          var oldScore = _game.score;
          _game.reply(correctAnswer);
          expect(_game.score == oldScore + (500 * 100 / 1000).floor(), true);
        });

        test('it emits reply events with the info for the animations and other UI', () {
          var completer = new Completer<bool>();
          Reply futureReply;
          _game.replyStream.listen((reply) {
            futureReply = reply;
            completer.complete(true);
          });

          _game.reply(correctAnswer);
          expect(completer.future, completion(true));
          completer.future.then((_) {
            expect(futureReply.isOk, true);
            expect(futureReply.answer, correctAnswer);
          });
        });
      });

      group('if the answer is wrong', () {
        Answer wrongAnswer;

        setUp(() {
          _game.start(_mockTimer, false);
          wrongAnswer = _game.answers.firstWhere(
            (answer) => answer.number != _game.question.number || answer.color != _game.question.color
          );
          when(_mockTimer.maxTimeInMilliseconds)
            .thenReturn(1000);
          when(_mockTimer.remainingInMilliseconds)
            .thenReturn(500);
        });

        group('and if the timer removes so many time that goes bellow zero', () {
          setUp(() {
            when(_mockTimer.fail())
              .thenReturn(true);
          });

          test('it returns false', () {
            expect(_game.reply(wrongAnswer), false);
          });

          test('it removes time from the timer', () {
            _game.reply(wrongAnswer);
            verify(_mockTimer.fail());
          });

          test('it emits gameover', () {
            var completer = Completer<bool>();

            _game.gameoverStream.listen((_) => completer.complete(true));
            _game.reply(wrongAnswer);

            expect(completer.future, completion(true));
          });
        });

        group('and if the timer still has time', () {
          setUp(() {
            when(_mockTimer.fail())
              .thenReturn(false);
          });

          test('it returns false', () {
            expect(_game.reply(wrongAnswer), false);
          });

          test('it removes time from the timer', () {
            _game.reply(wrongAnswer);
            verify(_mockTimer.fail());
          });

          test('it emits reply events with the info for the animations and other UI', () {
            var completer = new Completer<bool>();
            Reply futureReply;
            _game.replyStream.listen((reply) {
              futureReply = reply;
              completer.complete(true);
            });

            _game.reply(wrongAnswer);
            expect(completer.future, completion(true));
            completer.future.then((_) {
              expect(futureReply.isOk, false);
              expect(futureReply.answer, wrongAnswer);
            });
          });
        });
      });
    });
  });
}
