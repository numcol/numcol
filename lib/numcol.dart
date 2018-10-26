// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'view/index.dart';
import 'domain/index.dart';
import 'i18n/index.dart';
import 'screens/index.dart';
import 'middleware/index.dart';

var numcolRoutes = {
  routes[Routes.home]: (context) => HomeScreen(),
  routes[Routes.game]: (context) => GameScreen(),
  routes[Routes.countdown]: (context) => CountdownScreen(),
  routes[Routes.gameover]: (context) => GameoverScreen(),
  routes[Routes.settings]: (context) => SettingsScreen(),
};

class NumcolApp extends StatefulWidget {
  @override
  _NumcolAppState createState() => _NumcolAppState();
}
class _NumcolAppState extends State<NumcolApp> {
  FirebaseAnalytics _analytics;
  TranslationsDelegate _newLocaleDelegate;
  String _chosenLocale;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = TranslationsDelegate(newLocale: null);
    localeChanger.onLocaleChanged = onLocaleChange;
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = TranslationsDelegate(newLocale: locale);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _analytics = Injector.of(context).inject<FirebaseAnalytics>();
    var chosenLocale = Injector.of(context).inject<StorageContract>().getLanguage();
    if (chosenLocale != null && chosenLocale != _chosenLocale) {
      onLocaleChange(new Locale(chosenLocale, ''));
    }
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    var path = settings.name.split('/');
    if (path[0] == routes[Routes.gameover]) {
      final score = path.length > 1 ? int.parse(path[1]) : null;
      return new MaterialPageRoute(
        builder: (context) => GameoverScreen(score: score),
        settings: settings,
      );
    } else if (path[0] == routes[Routes.game]) {
      final isZenMode = path[1] != null && path[1] == 'true';
      return new MaterialPageRoute(
        builder: (context) => GameScreen(isZenMode: isZenMode),
        settings: settings,
      );
    } else if (numcolRoutes[path[0]] != null) {
      return new MaterialPageRoute(
        builder: numcolRoutes[path[0]],
        settings: settings,
      );
    }

    return new MaterialPageRoute(
      builder: numcolRoutes[routes[Routes.home]],
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NumCol',
      initialRoute: '/',
      localizationsDelegates: [
        _newLocaleDelegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: Translations.supportedLocales(),
      onGenerateRoute: _onGenerateRoute,
      navigatorObservers: [
        new FirebaseAnalyticsObserver(analytics: _analytics),
      ],
    );
  }
}
