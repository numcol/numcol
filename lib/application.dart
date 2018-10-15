import 'package:flutter/material.dart';
import 'core/index.dart';

typedef void LocaleChangeCallback(Locale locale);

class Application {
  final List<String> supportedLanguages = LanguageHelper.getAllLanguageCodes();

  final int initialTimeInMilliseconds = 10000;
  final double timePenaltyMultiplier = 0.66;
  final int timeAdditionByAnswerInMilliseconds = 1800;

  Iterable<Locale> supportedLocales() => supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));

  LocaleChangeCallback onLocaleChanged;

  static final Application _application = new Application._internal();

  factory Application() {
      return _application;
  }

  Application._internal();
}

Application application = new Application();
