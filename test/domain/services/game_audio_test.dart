// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../../lib/domain/index.dart';

class MockStorage extends Mock implements StorageContract {}
class MockAudioPlayer extends Mock implements AudioPlayerContract {}

void main() {

  MockStorage _mockStorage;
  MockAudioPlayer _mockAudioPlayer;
  GameAudio _gameAudio;

  setUp(() async {
    _mockStorage = MockStorage();
    _mockAudioPlayer = MockAudioPlayer();
    _gameAudio = GameAudio(
      _mockStorage,
      _mockAudioPlayer);
  });

  group('Game Audio:', () {
    group('When audio is on', () {

      setUp(() async {
        when(_mockStorage.getIsAudioOn())
          .thenReturn(true);
      });

      group('on play click sound', () {
        test('it plays the click sound', () {
          _gameAudio.playClickSound();
          verify(_mockAudioPlayer.play(Sounds.click));
        });
      });

      group('on play gameover sound', () {
        test('it plays the gameover sound', () {
          _gameAudio.playGameOverSound();
          verify(_mockAudioPlayer.play(Sounds.gameover));
        });
      });

      group('on play start sound', () {
        test('it plays the start sound', () {
          _gameAudio.playStartSound();
          verify(_mockAudioPlayer.play(Sounds.start));
        });
      });

      group('on play wrong sound', () {
        test('it plays the wrong sound', () {
          _gameAudio.playWrongSound();
          verify(_mockAudioPlayer.play(Sounds.wrong));
        });
      });
    });

    group('When audio is off', () {

      setUp(() async {
        when(_mockStorage.getIsAudioOn())
          .thenReturn(false);
      });

      group('on play click sound', () {
        test('it does not play the click sound', () {
          _gameAudio.playClickSound();
          verifyNever(_mockAudioPlayer.play(Sounds.click));
        });
      });

      group('on play gameover sound', () {
        test('it does not play the gameover sound', () {
          _gameAudio.playGameOverSound();
          verifyNever(_mockAudioPlayer.play(Sounds.gameover));
        });
      });

      group('on play start sound', () {
        test('it does not play the start sound', () {
          _gameAudio.playStartSound();
          verifyNever(_mockAudioPlayer.play(Sounds.start));
        });
      });

      group('on play wrong sound', () {
        test('it does not play the wrong sound', () {
          _gameAudio.playWrongSound();
          verifyNever(_mockAudioPlayer.play(Sounds.wrong));
        });
      });
    });
  });
}
