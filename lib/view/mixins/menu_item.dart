// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart' hide Color;

import '../../domain/index.dart';
import '../../i18n/index.dart';
import '../widgets/index.dart';

abstract class MenuItemMixin<T extends StatefulWidget> extends State<T> {
  factory MenuItemMixin._() => null;

  Widget menuItem(
      Color color, String languageTag, NumcolButtonPressed command) {
    return MenuButton(
      color: color,
      text: Translations.of(context).text(languageTag),
      onPressed: command,
    );
  }
}
