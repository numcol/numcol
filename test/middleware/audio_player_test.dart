// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:audioplayers/audio_cache.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../lib/middleware/audio_player.dart';
import '../../lib/middleware/storage.dart';

class MockStorage extends Mock implements Storage {}

class MockPlayer extends Mock implements AudioCache {}

void main() {
  MockStorage _mockStorage;
  MockPlayer _mockPlayer;
  AudioPlayer _gameAudio;

  setUp(() async {
    _mockStorage = MockStorage();
    _mockPlayer = MockPlayer();
    _gameAudio = AudioPlayer(_mockStorage, _mockPlayer);
  });

  group('Audio Player:', () {
    group('When audio is on', () {
      setUp(() async {
        when(_mockStorage.getIsAudioOn()).thenReturn(true);
      });

      group('on play click sound', () {
        test('it plays the click sound', () {
          _gameAudio.playClickSound();
          verify(_mockPlayer.play('click.mp3'));
        });
      });

      group('on play gameover sound', () {
        test('it plays the gameover sound', () {
          _gameAudio.playGameOverSound();
          verify(_mockPlayer.play('gameover.mp3'));
        });
      });

      group('on play start sound', () {
        test('it plays the start sound', () {
          _gameAudio.playStartSound();
          verify(_mockPlayer.play('start.mp3'));
        });
      });

      group('on play wrong sound', () {
        test('it plays the wrong sound', () {
          _gameAudio.playWrongSound();
          verify(_mockPlayer.play('wrong.mp3'));
        });
      });
    });

    group('When audio is off', () {
      setUp(() async {
        when(_mockStorage.getIsAudioOn()).thenReturn(false);
      });

      group('on play click sound', () {
        test('it does not play the click sound', () {
          _gameAudio.playClickSound();
          verifyNever(_mockPlayer.play('click.mp3'));
        });
      });

      group('on play gameover sound', () {
        test('it does not play the gameover sound', () {
          _gameAudio.playGameOverSound();
          verifyNever(_mockPlayer.play('gameover.mp3'));
        });
      });

      group('on play start sound', () {
        test('it does not play the start sound', () {
          _gameAudio.playStartSound();
          verifyNever(_mockPlayer.play('start.mp3'));
        });
      });

      group('on play wrong sound', () {
        test('it does not play the wrong sound', () {
          _gameAudio.playWrongSound();
          verifyNever(_mockPlayer.play('wrong.mp3'));
        });
      });
    });
  });
}
