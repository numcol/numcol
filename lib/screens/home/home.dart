import 'package:flutter/material.dart' hide Color;
import 'package:numcolengine/numcolengine.dart';

import '../../widgets/menu_button.dart';
import '../../strings.dart';
import '../../styles.dart';
import '../../translations.dart';
import '../../routes.dart';

class HomeScreen extends StatelessWidget {

  Container _title() {
    return Container(
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
    );
  }

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
                child: _title(),
              ),
              MenuButton(
                color: Color.green,
                text: Translations.of(context).text('play'),
                onPressed: () => Navigator.pushNamed(context, Routes.countdown),
              ),
              MenuButton(
                color: Color.yellow,
                text: Translations.of(context).text('zen_mode'),
                onPressed: () => Navigator.pushNamed(context, Routes.countdown),
              ),
              MenuButton(
                color: Color.blue,
                text: Translations.of(context).text('top_score'),
                onPressed: () => Navigator.pushNamed(context, Routes.countdown),
              ),
              MenuButton(
                color: Color.red,
                text: Translations.of(context).text('settings'),

                onPressed: () => Navigator.pushNamed(context, Routes.countdown),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
