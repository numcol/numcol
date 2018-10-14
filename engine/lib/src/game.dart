import 'answer.dart';
import 'random_generator.dart';

class Game {
  Game() {
    _question = RandomGenerator.generateQuestion(_answers);
  }

  final List<Answer> _answers = RandomGenerator.generateAnswers();
  Answer _question;
  int _score = 0;

  List<Answer> get answers => _answers;
  Answer get question => _question;
  int get score => _score;

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
