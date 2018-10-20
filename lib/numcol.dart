// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'view/index.dart';
import 'domain/index.dart';
import 'i18n/index.dart';
import 'services/index.dart';
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
    Injector.of(context).inject<StorageContract>().getLanguage()
      .then((chosenLocale) {
        if (chosenLocale != null && chosenLocale != _chosenLocale) {
          onLocaleChange(new Locale(chosenLocale, ''));
        }
      });
  }
/*
  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    var path = settings.name.split('/');
    if (path[0] == "myRoute") {
      final foo = path.length > 1 ? int.parse(path[1]) : null;
      return new MaterialPageRoute(
        builder: (context) => new MyPage(foo: foo),
        settings: settings,
      );
    }

    return null;
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NumCol',
      initialRoute: '/',
      routes: {
        routes[Routes.home]: (context) => HomeScreen(),
        routes[Routes.game]: (context) => GameScreen(),
        routes[Routes.countdown]: (context) => CountdownScreen(),
        routes[Routes.gameover]: (context) => GameoverScreen(),
        routes[Routes.settings]: (context) => SettingsScreen(),
      },
      localizationsDelegates: [
        _newLocaleDelegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: Translations.supportedLocales(),
      /*onGenerateRoute: _onGenerateRoute,*/
    );
  }
}
