// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../lib/screens/game/widgets/question/question_presenter.dart';
import '../../../../../lib/domain/index.dart';

class MockQuestionView extends Mock implements QuestionViewContract {}
class MockQuestionAnimator extends Mock implements AnimatorContract {}

void main() {
  MockQuestionView _mockQuestionView;
  MockQuestionAnimator _mockNumberQuestionAnimator;
  MockQuestionAnimator _mockColorQuestionAnimator;
  QuestionPresenter _questionPresenter;

  group('Question Widget:', () {
    setUp(() {
      _mockQuestionView = MockQuestionView();
      _mockNumberQuestionAnimator = MockQuestionAnimator();
      _mockColorQuestionAnimator = MockQuestionAnimator();
      _questionPresenter = QuestionPresenter(
        _mockQuestionView);
      when(_mockQuestionView.numberAnimator)
        .thenReturn(_mockNumberQuestionAnimator);
      when(_mockQuestionView.colorAnimator)
        .thenReturn(_mockColorQuestionAnimator);
    });

    group('On reply', () {
      Reply reply;
      Question question;

      group('when the reply is correct', () {
        setUp(() {
          reply = Reply(true, Answer(2, Color.red, Number.three));
          question = Question(Answer(2, Color.red, Number.three));
          when(_mockQuestionView.question)
            .thenReturn(question);
        });

        test('it does not start any animation', () {
          _questionPresenter.onReply(reply);

          verifyNever(_mockNumberQuestionAnimator.forward());
          verifyNever(_mockColorQuestionAnimator.forward());
        });
      });

      group('when the reply is not correct', () {
        setUp(() {
          question = Question(Answer(2, Color.red, Number.three));
          when(_mockQuestionView.question)
            .thenReturn(question);
        });

        test('if the color is not ok it starts the animation of the color of the question', () {
          reply = Reply(false, Answer(2, Color.blue, Number.three));

          _questionPresenter.onReply(reply);

          verify(_mockColorQuestionAnimator.forward());
          verifyNever(_mockNumberQuestionAnimator.forward());
        });

        test('if the number is not ok it starts the animation of the number of the question', () {
          reply = Reply(false, Answer(2, Color.red, Number.eight));

          _questionPresenter.onReply(reply);

          verify(_mockNumberQuestionAnimator.forward());
          verifyNever(_mockColorQuestionAnimator.forward());
        });
      });
    });
  });
}
