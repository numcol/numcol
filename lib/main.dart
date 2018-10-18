// NumCol - The Brain Training Game About Matching Numbers And Colours.
// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';

import 'configuration.dart';
import 'numcol.dart';
import 'services/index.dart';

void main() {
  runApp(
    Configuration(
      initialTimeInMilliseconds: 10000,
      timePenaltyMultiplier: 0.66,
      timeAdditionByAnswerInMilliseconds: 1800,
      child: Injector(
        storage: Storage(),
        animatorFactory: AnimatorFactory(),
        child: Numcol(),
      ),
    ),
  );
}
