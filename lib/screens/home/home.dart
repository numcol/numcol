import 'package:flutter/material.dart' hide Color;
import 'package:numcolengine/numcolengine.dart';

import '../../widgets/numcol_button.dart';
import '../../strings.dart';
import '../../styles.dart';
import '../../translations.dart';
import '../../routes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  padding: const EdgeInsets.only(
                    bottom: 60.0
                  ),
                  child: Text(
                    'NumCol',
                    style: TextStyle(
                      fontSize: 72.0,
                      color: ScreenColors.black,
                      fontFamily: Fonts.poiretone,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 15.0,
                ),
                height: 60.0,
                width: 240.0,
                child: NumcolButton(
                  color: Color.green,
                  text: Translations.of(context).text('play'),
                  onPressed: () => Navigator.pushNamed(context, Routes.countdown),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 15.0,
                ),
                height: 60.0,
                width: 240.0,
                child: NumcolButton(
                  color: Color.yellow,
                  text: Translations.of(context).text('kids_level'),
                  onPressed: () => Navigator.pushNamed(context, Routes.countdown),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 15.0,
                ),
                height: 60.0,
                width: 240.0,
                child: NumcolButton(
                  color: Color.blue,
                  text: Translations.of(context).text('top_score'),
                  onPressed: () => Navigator.pushNamed(context, Routes.countdown),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 15.0,
                ),
                height: 60.0,
                width: 240.0,
                child: NumcolButton(
                  color: Color.red,
                  text: Translations.of(context).text('settings'),

                  onPressed: () => Navigator.pushNamed(context, Routes.countdown),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
