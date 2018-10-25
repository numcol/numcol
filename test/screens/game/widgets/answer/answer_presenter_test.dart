// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../lib/screens/game/widgets/answer/answer_presenter.dart';
import '../../../../../lib/domain/index.dart';

class MockAnswerView extends Mock implements AnswerViewContract {}
class MockGame extends Mock implements Game {}

void main() {
  MockAnswerView _mockAnswerView;
  MockGame _mockGame;
  AnswerPresenter _answerPresenter;

  group('Answer Widget:', () {
    setUp(() async {
      _mockAnswerView = MockAnswerView();
      _mockGame = MockGame();
      _answerPresenter = AnswerPresenter(
        _mockAnswerView,
        _mockGame);
    });

    group('On pressed', () {
      test('it replies to the game question with pressed answer', () {
        var answer = Answer(2, Color.red, Number.three);
        when(_mockAnswerView.reply)
          .thenReturn(answer);
        when(_mockGame.reply(answer))
          .thenReturn(true);

        _answerPresenter.onPressed();

        verify(_mockGame.reply(answer));
      });

      test('it shakes if the answer is wrong', () {
        var answer = Answer(2, Color.red, Number.three);
        when(_mockAnswerView.reply)
          .thenReturn(answer);
        when(_mockGame.reply(answer))
          .thenReturn(false);

        _answerPresenter.onPressed();

        verify(_mockAnswerView.shake());
        verifyNever(_mockAnswerView.renew());
      });

      test('it renews the answer', () {
        var answer = Answer(2, Color.red, Number.three);
        when(_mockAnswerView.reply)
          .thenReturn(answer);
        when(_mockGame.reply(answer))
          .thenReturn(true);

        _answerPresenter.onPressed();

        verify(_mockAnswerView.renew());
        verifyNever(_mockAnswerView.shake());
      });
    });
  });
}
