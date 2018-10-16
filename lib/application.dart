import 'package:flutter/material.dart';
import 'core/index.dart';

typedef void LocaleChangeCallback(Locale locale);

class Application {
  final List<String> supportedLanguages = LanguageHelper.getAllLanguageCodes();

  Iterable<Locale> supportedLocales() => supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));

  LocaleChangeCallback onLocaleChanged;

  static final Application _application = new Application._internal();

  factory Application() {
      return _application;
  }

  Application._internal();
}

Application application = new Application();
