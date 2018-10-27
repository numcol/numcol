// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class Responsive {
  static T getValue<T>(BuildContext context, T normal, T large, T extralarge) {
    if (MediaQuery.of(context).size.width > 728) {
      return extralarge;
    }

    if (MediaQuery.of(context).size.width > 540) {
      return large;
    }

    return normal;
  }
}
