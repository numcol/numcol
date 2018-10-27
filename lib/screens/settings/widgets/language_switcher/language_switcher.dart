// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart' hide Color;

import '../../../../domain/index.dart';
import '../../../../middleware/index.dart';
import '../../../../i18n/index.dart';
import '../../../../view/index.dart';
import 'language_switcher_presenter.dart';

class LanguageSwitcher extends StatefulWidget {
  @override
  _LanguageSwitcherState createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher>
    implements LanguageSwitcherViewContract {
  final GlobalKey<CustomExpansionTileState> expansionTile = GlobalKey();
  Locales _locale;
  LanguageSwitcherPresenter _presenter;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _presenter =
        LanguageSwitcherPresenter(this, Injector.of(context).inject<Storage>());
    _presenter.loadChosenLanguage();
  }

  void onLoadChosenLanguageComplete(Locales chosenLocale) {
    setState(() {
      _locale = chosenLocale;
    });
  }

  void onLanguageSaved(Locales chosenLocale) {
    var languageCode = LocaleHelper.getLanguageCode(chosenLocale);
    var newLocale = Locale(languageCode, '');
    localeChanger.onLocaleChanged(newLocale);
    setState(() {
      _locale = chosenLocale;
    });
    _showSavedMessage();
    expansionTile.currentState.collapse();
  }

  void onLanguageSavedError() {
    final snackBar = SnackBar(
      content: Text(Translations.of(context).text('savedError')),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _showSavedMessage() {
    final snackBar = SnackBar(
      content: Text(Translations.of(context).text('saved')),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  List<Widget> _buildLanguageTiles() {
    var locales = LocaleHelper.getLocales();
    if (_locale != null) {
      locales.remove(_locale);
    }

    return locales
        .map((locale) => ListTile(
              title: Text(LocaleHelper.getLanguageText(locale)),
              onTap: () => _presenter.onLanguagePressed(locale),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.getValue(context, 240.0, 370.0, 480.0),
      padding: EdgeInsets.only(
        bottom: Responsive.getValue(context, 15.0, 20.0, 35.0),
      ),
      child: CustomExpansionTile(
        key: expansionTile,
        title: Text(LocaleHelper.getLanguageText(_locale) ??
            Translations.of(context).text('languages')),
        children: _buildLanguageTiles(),
      ),
    );
  }
}
