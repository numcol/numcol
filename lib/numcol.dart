// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'i18n/index.dart';
import 'services/index.dart';
import 'routes.dart';
import 'screens/index.dart';

class Numcol extends StatefulWidget {
  @override
  _NumcolState createState() => _NumcolState();
}
class _NumcolState extends State<Numcol> {
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
    Injector.of(context).storage.getLanguage()
      .then((chosenLocale) {
        if (chosenLocale != null && chosenLocale != _chosenLocale) {
          onLocaleChange(new Locale(chosenLocale, ''));
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NumCol',
      initialRoute: '/',
      routes: {
        Routes.home: (context) => HomeScreen(),
        Routes.game: (context) => GameScreen(),
        Routes.countdown: (context) => CountdownScreen(),
        Routes.gameover: (context) => GameoverScreen(),
        Routes.settings: (context) => SettingsScreen(),
      },
      localizationsDelegates: [
        _newLocaleDelegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: Translations.supportedLocales(),
    );
  }
}
