// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class Page extends StatelessWidget {
  const Page({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: MediaQuery.of(context).size.width > 540
            ? const EdgeInsets.all(50.0)
            : const EdgeInsets.all(15.0),
        child: child,
      ),
    );
  }
}
