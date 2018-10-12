import 'dart:math';

import 'enums.dart';
import 'answer.dart';

var colors = Color.values;
var numbers = Number.values;

Number _randomNumber() {
  final random = new Random();
  return numbers[random.nextInt(numbers.length)];
}

Color _randomColour() {
  final random = new Random();
  return colors[random.nextInt(colors.length)];
}

class RandomGenerator {
  static Answer generateAnswer() {
    return new Answer(_randomColour(), _randomNumber());
  }

  static List<Answer> generateAnswers() {
    var questions = new List<Answer>();

    for (var i = 0; i < 36; i++) {
      questions.add(RandomGenerator.generateAnswer());
    }

    return questions;
  }

  static Answer generateQuestion(List<Answer> answers) {
    final _random = new Random();
    return answers[_random.nextInt(answers.length)];
  }
}
