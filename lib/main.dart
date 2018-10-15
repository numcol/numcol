import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'application.dart';
import 'core/services/translations.dart';
import 'routes.dart';
import 'screens/index.dart';

void main() => runApp(Numcol());

class Numcol extends StatefulWidget {
  @override
  _NumcolState createState() => new _NumcolState();
}
class _NumcolState extends State<Numcol> {
  TranslationsDelegate _newLocaleDelegate;

  @override
  void initState(){
    super.initState();
    _newLocaleDelegate = new TranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  onLocaleChange(Locale locale){
    setState(() {
      _newLocaleDelegate = new TranslationsDelegate(newLocale: locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'NumCol',
      initialRoute: '/',
      routes: {
        Routes.home: (context) => HomeScreen(),
        Routes.game: (context) => GameScreen(),
        Routes.countdown: (context) => CountdownScreen(),
        Routes.gameover: (context) => GameoverScreen(),
      },
      localizationsDelegates: [
        _newLocaleDelegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: application.supportedLocales(),
    );
  }
}
