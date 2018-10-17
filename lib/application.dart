// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

typedef void LocaleChangeCallback(Locale locale);

class Application {
  LocaleChangeCallback onLocaleChanged;

  static final Application _application = new Application._internal();

  factory Application() {
      return _application;
  }

  Application._internal();
}

Application application = new Application();
