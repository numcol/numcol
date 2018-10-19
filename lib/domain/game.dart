// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'answer.dart';
import 'dart:math';
import 'enums.dart';

const colors = Color.values;
const numbers = Number.values;

class Game {
  Game();

  List<Answer> _answers;
  Answer _question;
  int _score;

  List<Answer> get answers => _answers;
  Answer get question => _question;
  int get score => _score;

  void start() {
    _answers = _RandomGenerator.generateAnswers();
    _question = _RandomGenerator.generateQuestion(_answers);
    _score = 0;
  }

  bool checkAnswer(Answer answer) {
    return _question.color == answer.color && _question.number == answer.number;
  }

  int nextQuestion(Answer answer, int remainingTime, int timeLimit) {
    var index = _answers.indexOf(answer);
    _answers[index] = _RandomGenerator.generateAnswer();
    _question = _RandomGenerator.generateQuestion(_answers);
    _addPoints(remainingTime, timeLimit);

    return index;
  }

  void _addPoints(int remainingTime, int timeLimit) {
    _score += (remainingTime * 100 / timeLimit).floor();
  }
}

class _RandomGenerator {
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
