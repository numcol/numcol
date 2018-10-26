// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

typedef void LocaleChangeCallback(Locale locale);

class LocaleChanger {
  LocaleChangeCallback onLocaleChanged;

  static final LocaleChanger _localeChanger = LocaleChanger._internal();

  factory LocaleChanger() {
    return _localeChanger;
  }

  LocaleChanger._internal();
}

LocaleChanger localeChanger = LocaleChanger();
