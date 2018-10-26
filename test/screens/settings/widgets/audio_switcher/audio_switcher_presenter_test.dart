// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../lib/domain/index.dart';
import '../../../../../lib/screens/settings/widgets/audio_switcher/audio_switcher_presenter.dart';

class MockAudioSwitcherView extends Mock implements AudioSwitcherViewContract {}

class MockStorage extends Mock implements StorageContract {}

void main() {
  MockStorage _mockStorage;
  MockAudioSwitcherView _mockAudioSwitcherView;
  AudioSwitcherPresenter _audioSwitcherPresenter;

  setUp(() async {
    _mockAudioSwitcherView = MockAudioSwitcherView();
    _mockStorage = MockStorage();
    _audioSwitcherPresenter =
        AudioSwitcherPresenter(_mockAudioSwitcherView, _mockStorage);
  });

  group('Audio Switcher:', () {
    group('On load', () {
      test(
          'it gets user preferred audio setting and it calls complete action to refresh screen',
          () {
        when(_mockStorage.getIsAudioOn()).thenReturn(true);

        _audioSwitcherPresenter.loadIsAudioOn();

        verify(_mockStorage.getIsAudioOn());
        verify(_mockAudioSwitcherView.onLoadIsAudioOn(true));
      });
    });

    group('On audio setting selected', () {
      test('saves the changes and it notifies the UI about the saved changes',
          () {
        final future = new Future.value(true);
        when(_mockStorage.setIsAudioOn(true)).thenAnswer((_) => future);

        _audioSwitcherPresenter.onTogglePressed(true);

        future.then((_) {
          verify(_mockStorage.setIsAudioOn(true));
          verify(_mockAudioSwitcherView.onIsAudioOnSaved(true));
        });
      });

      test('it notifies the UI about the errors saving changes', () {
        final future = new Future.value(false);
        when(_mockStorage.setIsAudioOn(true)).thenAnswer((_) => future);

        _audioSwitcherPresenter.onTogglePressed(true);

        future.then((_) {
          verify(_mockAudioSwitcherView.onIsAudioOnSavedError());
        });
      });
    });
  });
}
