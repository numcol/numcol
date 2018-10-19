import 'package:flutter/material.dart' hide Color;

import '../domain/index.dart';
import 'numcol_button.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key key,
    @required this.text,
    @required this.color,
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final Color color;
  final NumcolButtonPressed onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 15.0,
      ),
      height: 60.0,
      width: 240.0,
      child: NumcolButton(
        color: color,
        text: text,
        onPressed: onPressed,
      ),
    );
  }
}
