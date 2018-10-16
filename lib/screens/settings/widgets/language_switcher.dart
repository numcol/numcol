import 'package:flutter/material.dart' hide Color;

import '../../../application.dart';
import '../../../core/index.dart';
import '../../../widgets/index.dart';

class LanguageSwitcher extends StatefulWidget {
  @override
  _LanguageSwitcherState createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  final GlobalKey<CustomExpansionTileState> expansionTile = new GlobalKey();
  Locales _locale;

  @override
  void initState() {
    super.initState();
    Storage.getLanguage()
      .then((chosenLocale) {
        if (chosenLocale != null) {
          setState(() {
            _locale = LanguageHelper.getLocaleByLanguageCode(chosenLocale);
          });
        }
      });
  }

  void _showSavedMessage() {
    final snackBar = SnackBar(
      content: Text(Translations.of(context).text('saved')),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _showErrorMessage() {
    final snackBar = SnackBar(
      content: Text(Translations.of(context).text('savedError')),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _onTap(Locales locale) {
    var languageCode = LanguageHelper.getLanguageCode(locale);
    var newLocale = new Locale(languageCode, '');
    Storage.setLanguage(languageCode)
      .then((isSaved) {
        if (isSaved) {
          application.onLocaleChanged(newLocale);
          setState(() {
            _locale = locale;
          });
          _showSavedMessage();
        } else {
          _showErrorMessage();
        }
        expansionTile.currentState.collapse();
      });
  }

  @override
  Widget build(BuildContext context) {

    var locales = LanguageHelper.getLocales();
    if (_locale != null) {
      locales.remove(_locale);
    }

    return Container(
      width: 240.0,
      child: CustomExpansionTile(
        key: expansionTile,
        title: Text(LanguageHelper.getLanguageText(_locale) ?? Translations.of(context).text('languages')),
        children: locales.map((locale) => ListTile(
          title: Text(LanguageHelper.getLanguageText(locale)),
          onTap: () => _onTap(locale),
        )).toList(),
      ),
    );
  }
}