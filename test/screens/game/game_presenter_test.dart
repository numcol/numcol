// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'dart:async';

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../../lib/domain/index.dart';
import '../../../lib/services/index.dart';
import '../../../lib/screens/game/game_presenter.dart';

class MockGameScreenView extends Mock implements GameScreenViewContract {}
class MockTimer extends Mock implements GameTimer {}
class MockGame extends Mock implements Game {}

class MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  MockGameScreenView _mockGameScreenView;
  MockTimer _mockTimer;
  MockGame _mockGame;
  MockAudioPlayer _mockAudio;
  GameScreenPresenter _gameScreenPresenter;
  StreamController<Reply> _replyStreamer;
  StreamController _gameoverStreamer;

  setUp(() async {
    _replyStreamer = StreamController.broadcast();
    _gameoverStreamer = StreamController.broadcast();
    _mockGameScreenView = MockGameScreenView();
    _mockTimer = MockTimer();
    _mockGame = MockGame();
    _mockAudio = MockAudioPlayer();
    _gameScreenPresenter = GameScreenPresenter(_mockGameScreenView, _mockGame, _mockAudio);
    when(_mockGame.replyStream)
        .thenAnswer((_) => _replyStreamer.stream);
    when(_mockGame.gameoverStream)
        .thenAnswer((_) => _gameoverStreamer.stream);
  });

  group('Game Screen:', () {
    group('On load', () {
      test('the game starts with the new timer', () {
        _gameScreenPresenter.onLoad(_mockTimer);
        verify(_mockGame.start(_mockTimer));
      });

      group('a listener is added to gameover event and when it triggers', () {
        test('it plays gameover sound', () {
          _gameoverStreamer.add(null);
          _gameoverStreamer.done.then((_) {
            verify(_mockAudio.playGameOverSound());
          });
        });
        test('it redirects to game over screen', () {
          _gameoverStreamer.add(null);
          _gameoverStreamer.done.then((_) {
            verify(_mockGameScreenView.redirectToWithParameter(Routes.gameover, any));
          });
        });
      });

      group('a listener is added to the reply event and when it triggers', () {
        test('it plays click sound if the reply is ok', () {
          when(_mockGame.reply(any))
            .thenReturn(true);
          _replyStreamer.add(null);
          _replyStreamer.done.then((_) {
            verify(_mockAudio.playClickSound());
          });
        });
        test('it plays wrong sound if the reply is wrong', () {
          when(_mockGame.reply(any))
            .thenReturn(false);
          _replyStreamer.add(null);
          _replyStreamer.done.then((_) {
            verify(_mockAudio.playWrongSound());
          });
        });
      });
    });

    group('On get answers', () {
      test('it return game answers', () {
        var answers = <Answer>[
          Answer(1, Color.blue, Number.one),
        ];
        when(_mockGame.answers)
          .thenReturn(answers);
        expect(_gameScreenPresenter.answers, answers);
      });
    });

    group('On get question', () {
      test('it return game question', () {
        var question = Question(Answer(1, Color.blue, Number.one));
        when(_mockGame.question)
          .thenReturn(question);
        expect(_gameScreenPresenter.question, question);
      });
    });

    group('On get score', () {
      test('it return game score', () {
        var score = 123;
        when(_mockGame.score)
          .thenReturn(score);
        expect(_gameScreenPresenter.score, score);
      });
    });
  });
}
