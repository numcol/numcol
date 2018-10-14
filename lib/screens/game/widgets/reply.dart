import 'package:flutter/material.dart';
import 'package:numcolengine/numcolengine.dart';

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
