// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../../domain/index.dart';

class ReplyInheritedWidget extends InheritedWidget {
  const ReplyInheritedWidget({
    Key key,
    @required this.reply,
    Widget child}) : super(key: key, child: child);

  final ValueNotifier<Answer> reply;

  @override
  bool updateShouldNotify(ReplyInheritedWidget old) {
    return reply != old.reply;
  }

  static ReplyInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ReplyInheritedWidget);
  }
}
