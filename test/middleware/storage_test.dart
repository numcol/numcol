// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../../lib/middleware/storage.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {

  Storage _storage;
  MockSharedPreferences _mockPreferences;

  setUp(() async {
    _mockPreferences = MockSharedPreferences();
    _storage = Storage(_mockPreferences);
  });

  group('Storage:', () {
    group('On get language', () {
      test('retrieves the language from the storage', () {
        when(_mockPreferences.getString('language'))
          .thenReturn('eu');

        expect(_storage.getLanguage(), 'eu');
      });
    });

    group('On set language', () {
      test('stores the language in the storage', () {
        _storage.setLanguage('eu');
        verify(_mockPreferences.setString('language', 'eu'));
      });
    });

    group('On get top score', () {
      test('retrieves the top score from the storage', () {
        when(_mockPreferences.getInt('top_score'))
          .thenReturn(23);

        expect(_storage.getTopScore(), 23);
      });

      test('retrieves zero if there is nothing in the storage', () {
        when(_mockPreferences.getInt('top_score'))
          .thenReturn(null);

        expect(_storage.getTopScore(), 0);
      });
    });

    group('On set top score', () {
      test('stores the top score in the storage', () {
        _storage.setTopScore(32);
        verify(_mockPreferences.setInt('top_score', 32));
      });
    });

    group('On get is audio on', () {
      test('retrieves is audio on from the storage', () {
        when(_mockPreferences.getBool('audio_on'))
          .thenReturn(false);

        expect(_storage.getIsAudioOn(), false);
      });

      test('retrieves true if there is nothing in the storage', () {
        when(_mockPreferences.getBool('audio_on'))
          .thenReturn(null);

        expect(_storage.getIsAudioOn(), true);
      });
    });

    group('On set is audio on', () {
      test('stores is audio on in the storage', () {
        _storage.setIsAudioOn(false);
        verify(_mockPreferences.setBool('audio_on', false));
      });
    });
  });
}
