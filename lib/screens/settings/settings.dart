import 'package:flutter/material.dart' hide Color;
import 'package:numcolengine/numcolengine.dart';

import 'widgets/index.dart';
import '../../widgets/index.dart';
import '../../core/index.dart';
import '../../styles.dart';

class SettingsScreen extends StatelessWidget {

  Widget _buildTitle(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 60.0
        ),
        child: Text(
          Translations.of(context).text('settings').toUpperCase(),
          style: TextStyle(
            fontSize: 42.0,
            color: ScreenColors.black,
            fontFamily: Fonts.poiretone,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildTitle(context),
                  LanguageSwitcher(),
                  MenuButton(
                    color: Color.blue,
                    text: Translations.of(context).text('back_to_menu'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
