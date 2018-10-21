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
    setUp(() async {
      _mockQuestionView = MockQuestionView();
      _mockNumberQuestionAnimator = MockQuestionAnimator();
      _mockColorQuestionAnimator = MockQuestionAnimator();
      _questionPresenter = QuestionPresenter(
        _mockQuestionView,
        _mockColorQuestionAnimator,
        _mockNumberQuestionAnimator);
    });

    group('On "IsColorOk" value changed', () {
      test('if it is not ok it highlights the color of the question', () {
        when(_mockQuestionView.isColorOk)
          .thenReturn(false);

        _questionPresenter.onIsColorOkValueChanged();

        verify(_mockColorQuestionAnimator.forward());
      });

      test('if it is ok it does not highlight the color of the question', () {
        when(_mockQuestionView.isColorOk)
          .thenReturn(true);

        _questionPresenter.onIsColorOkValueChanged();

        verifyNever(_mockColorQuestionAnimator.forward());
      });
    });

    group('On "IsNumberOk" value changed', () {
      test('if it is not ok it highlights the number of the question', () {
        when(_mockQuestionView.isNumberOk)
          .thenReturn(false);

        _questionPresenter.onIsNumberOkValueChanged();

        verify(_mockNumberQuestionAnimator.forward());
      });

      test('if it is ok it does not highlight the number of the question', () {
        when(_mockQuestionView.isNumberOk)
          .thenReturn(true);

        _questionPresenter.onIsNumberOkValueChanged();

        verifyNever(_mockNumberQuestionAnimator.forward());
      });
    });

    group('On is color animation completed', () {
      test('it reverses the animation', () {
        _questionPresenter.onIsColorAnimationCompleted();

        verify(_mockColorQuestionAnimator.reverse());
      });
    });

    group('On is number animation completed', () {
      test('it reverses the animation', () {
        _questionPresenter.onIsNumberAnimationCompleted();

        verify(_mockNumberQuestionAnimator.reverse());
      });
    });

    group('On is color animation dismissed', () {
      test('it stops the animation', () {
        _questionPresenter.onIsColorAnimationDismissed();

        verify(_mockColorQuestionAnimator.stop());
      });
      test('it sets "IsColorOk" to true', () {
        _questionPresenter.onIsColorAnimationDismissed();

        verify(_mockQuestionView.isColorOk = true);
      });
    });

    group('On is number animation dismissed', () {
      test('it stops the animation', () {
        _questionPresenter.onIsNumberAnimationDismissed();

        verify(_mockNumberQuestionAnimator.stop());
      });
      test('it sets "isNumberOk" to true', () {
        _questionPresenter.onIsNumberAnimationDismissed();

        verify(_mockQuestionView.isNumberOk = true);
      });
    });
  });
}
