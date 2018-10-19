// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'dart:math';

import 'enums.dart';
import 'answer.dart';

var colors = Color.values;
var numbers = Number.values;

class RandomGenerator {
  static final _random = Random();

  static Answer generateAnswer() {
    return Answer(_randomColour(), _randomNumber());
  }

  static List<Answer> generateAnswers() {
    var questions = List<Answer>();

    for (var i = 0; i < 36; i++) {
      questions.add(generateAnswer());
    }

    return questions;
  }

  static Answer generateQuestion(List<Answer> answers) {
    return answers[_random.nextInt(answers.length)];
  }

  static Number _randomNumber() {
    return numbers[_random.nextInt(numbers.length)];
  }

  static Color _randomColour() {
    return colors[_random.nextInt(colors.length)];
  }
}
