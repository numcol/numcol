// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../../../../domain/index.dart';

abstract class AudioSwitcherViewContract {
  void onLoadIsAudioOn(bool isAudioOn);
  void onIsAudioOnSaved(bool isAudioOn);
  void onIsAudioOnSavedError();
}

class AudioSwitcherPresenter {
  AudioSwitcherPresenter(this._view, this._storage);

  final AudioSwitcherViewContract _view;
  final StorageContract _storage;

  void loadIsAudioOn() {
    var isAudioOn = _storage.getIsAudioOn();
    this._view.onLoadIsAudioOn(isAudioOn);
  }

  void onTogglePressed(bool isAudioOn) {
    _storage.setIsAudioOn(isAudioOn).then((isSaved) {
      if (isSaved) {
        this._view.onIsAudioOnSaved(isAudioOn);
      } else {
        this._view.onIsAudioOnSavedError();
      }
    });
  }
}
