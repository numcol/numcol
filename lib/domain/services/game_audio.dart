
// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../collections/index.dart';
import '../contracts/index.dart';

class GameAudio {
  const GameAudio(
    this._storage,
    this._player,
  );

  final StorageContract _storage;
  final AudioPlayerContract _player;

  bool _isAudioOn() {
    return _storage.getIsAudioOn();
  }

  void playClickSound() {
    if (_isAudioOn()) {
      _player.play(Sounds.click);
    }
  }

  void playGameOverSound() {
    if (_isAudioOn()) {
      _player.play(Sounds.gameover);
    }
  }

  void playNewRoundSound() {
    if (_isAudioOn()) {
      _player.play(Sounds.newround);
    }
  }

  void playStartSound() {
    if (_isAudioOn()) {
      _player.play(Sounds.start);
    }
  }

  void playWrongSound() {
    if (_isAudioOn()) {
      _player.play(Sounds.wrong);
    }
  }
}
