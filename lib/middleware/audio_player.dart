// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:audioplayers/audio_cache.dart';

import '../domain/contracts/index.dart';
import 'storage.dart';

enum Sounds { click, gameover, start, wrong }

const sounds = {
  Sounds.click: 'click.mp3',
  Sounds.gameover: 'gameover.mp3',
  Sounds.start: 'start.mp3',
  Sounds.wrong: 'wrong.mp3',
};

class AudioPlayer implements AudioPlayerContract {
  AudioPlayer(this._storage, this._player) {
    _player.loadAll(sounds.values.toList());
  }

  final AudioCache _player;
  final Storage _storage;

  void _play(Sounds sound) {
    if (_isAudioOn()) {
      _player.play(sounds[sound]);
    }
  }

  bool _isAudioOn() {
    return _storage.getIsAudioOn();
  }

  void playClickSound() {
    _play(Sounds.click);
  }

  void playGameOverSound() {
    _play(Sounds.gameover);
  }

  void playStartSound() {
    _play(Sounds.start);
  }

  void playWrongSound() {
    _play(Sounds.wrong);
  }
}
