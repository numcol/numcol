// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'answer.dart';
import 'random_generator.dart';

class Game {
  Game();

  List<Answer> _answers;
  Answer _question;
  int _score;

  List<Answer> get answers => _answers;
  Answer get question => _question;
  int get score => _score;

  void start() {
    _answers = RandomGenerator.generateAnswers();
    _question = RandomGenerator.generateQuestion(_answers);
    _score = 0;
  }

  bool checkAnswer(Answer answer) {
    return _question.color == answer.color && _question.number == answer.number;
  }

  int nextQuestion(Answer answer, int remainingTime, int timeLimit) {
    var index = _answers.indexOf(answer);
    _answers[index] = RandomGenerator.generateAnswer();
    _question = RandomGenerator.generateQuestion(_answers);
    _addPoints(remainingTime, timeLimit);

    return index;
  }

  void _addPoints(int remainingTime, int timeLimit) {
    _score += (remainingTime * 100 / timeLimit).floor();
  }
}
