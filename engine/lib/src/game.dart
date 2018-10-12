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
}
