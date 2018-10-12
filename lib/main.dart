import 'package:flutter/material.dart';
import 'routes.dart';
import 'screens/index.dart';

void main() => runApp(Numcol());

class Numcol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      initialRoute: '/',
      routes: {
        Routes.home: (context) => HomeScreen(),
        Routes.game: (context) => GameScreen(),
        Routes.countdown: (context) => CountdownScreen(),
      },
    );
  }
}
