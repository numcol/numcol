// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import '../collections/index.dart';
import 'numcol.dart';

class Answer extends Numcol {
  const Answer(this.id, Color color, Number number) : super(color, number);

  final int id;
}
