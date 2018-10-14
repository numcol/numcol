import 'dart:math';

import 'enums.dart';
import 'answer.dart';

var colors = Color.values;
var numbers = Number.values;

class RandomGenerator {
  static final _random = new Random();

  static Answer generateAnswer() {
    return new Answer(_randomColour(), _randomNumber());
  }

  static List<Answer> generateAnswers() {
    var questions = new List<Answer>();

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
