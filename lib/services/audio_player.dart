// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:audioplayers/audio_cache.dart';

import '../domain/index.dart';

const sounds = {
  Sounds.click: "click.mp3",
  Sounds.gameover: "gameover.mp3",
  Sounds.start: "start.mp3",
  Sounds.wrong: "wrong.mp3",
};

class AudioPlayer implements AudioPlayerContract {
  AudioPlayer() {
    player.loadAll(sounds.values.toList());
  }
  static AudioCache player = new AudioCache(prefix: 'audio/');

  @override
  void play(Sounds sound) {
    player.play(sounds[sound]);
  }
}
