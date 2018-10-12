import 'answer.dart';
import 'random_generator.dart';

class Game {
  Game() {
    _question = RandomGenerator.generateQuestion(_answers);
  }

  final List<Answer> _answers = RandomGenerator.generateAnswers();
  Answer _question;

  List<Answer> get answers {
    return _answers;
  }

  Answer get question {
    return _question;
  }

  bool checkAnswer(Answer answer) {
    return _question.color == answer.color && _question.number == answer.number;
  }

  void nextQuestion(Answer answer) {
    var index = _answers.indexOf(answer);
    _answers[index] = RandomGenerator.generateAnswer();
    _question = RandomGenerator.generateQuestion(_answers);
  }
}
