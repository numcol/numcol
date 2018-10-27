// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:firebase_admob/firebase_admob.dart';

class Ads {
  static InterstitialAd _intersitial;
  static Function _onCloseCallback;
  static InterstitialAd get intersitial => _intersitial;

  static final MobileAdTargetingInfo _targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>['613D3BC8753D1DDFC9AC79C4D921D4A2'],
    keywords: <String>['games', 'game', 'puzzle', 'brain', 'logic'],
    designedForFamilies: true,
  );

  static void init() {
    FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-5245097431906186~4949633239');
  }

  static void createInterstitialAd() {
    _intersitial?.dispose();
    _intersitial = InterstitialAd(
      adUnitId: 'ca-app-pub-5245097431906186/3361024382',
      targetingInfo: _targetingInfo,
      listener: (MobileAdEvent event) {
        switch (event) {
          case MobileAdEvent.closed:
            _onClose();
            break;
          default:
        }
      },
    )..load();
  }

  static void showOrContinue(Function ifNotLoadedCallback) async {
    _onCloseCallback = ifNotLoadedCallback;
    var isLoaded =
        _intersitial != null ? await _intersitial?.isLoaded() : false;
    if (isLoaded) {
      _intersitial?.show();
      return;
    }
    ifNotLoadedCallback?.call();
  }

  static void dispose() {
    _intersitial?.dispose();
  }

  static void _onClose() {
    _onCloseCallback?.call();
  }
}
