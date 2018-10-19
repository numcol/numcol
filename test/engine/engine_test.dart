// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'dart:math';

import 'package:test/test.dart';

import '../../lib/engine/index.dart';

void main() {
  group('constructor', () {
    test('Every game should have 36 possible answers', () {
      var game = new Game();
      expect(game.answers.length, 36);
    });

    test('Every game should have an answerable question', () {
      var game = new Game();
      expect(game.answers.indexOf(game.question) > -1, true);
    });

    test('Every game should start with 0 score', () {
      var game = new Game();
      expect(game.score, 0);
    });
  });

  group('checkAnswer', () {
    test('Should return true if the color and the number of the answer are the same as the question', () {
      var game = new Game();
      var answer = new Answer(game.question.color, game.question.number);
      expect(game.checkAnswer(answer), true);
    });

    test('Should fail if the color of the answer is not the same as the color of the question', () {
      var game = new Game();
      var answer = new Answer(
        game.question.color == Color.blue ? Color.red : Color.blue,
        game.question.number,
      );
      expect(game.checkAnswer(answer), false);
    });

    test('Should fail if the number of the answer is not the same as the number of the question', () {
      var game = new Game();
      var answer = new Answer(
        game.question.color,
        game.question.number == Number.one ? Number.two : Number.one,
      );
      expect(game.checkAnswer(answer), false);
    });
  });

  group('nextQuestion', () {
    test('Should replace the indicated answer', () {
      var game = new Game();
      final _random = new Random();
      var randomIndex = _random.nextInt(game.answers.length);
      var randomAnswer =  game.answers[randomIndex];

      game.nextQuestion(randomAnswer, 2, 1);

      expect(randomAnswer == game.answers[randomIndex], false);
    });

    test('Should renew the question', () {
      var game = new Game();
      final _random = new Random();
      var randomIndex = _random.nextInt(game.answers.length);
      var randomAnswer =  game.answers[randomIndex];
      var previousQuestion =  game.answers[randomIndex];

      game.nextQuestion(randomAnswer, 2, 1);

      expect(previousQuestion == game.question, false);
    });

    test('Should increase score', () {
      var game = new Game();
      final _random = new Random();
      var randomIndex = _random.nextInt(game.answers.length);
      var randomAnswer =  game.answers[randomIndex];

      game.nextQuestion(randomAnswer, 2, 1);

      expect(game.score > 0, true);
    });
  });
}
