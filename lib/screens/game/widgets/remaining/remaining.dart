import 'package:flutter/material.dart';

import 'remaining_counter.dart';
import '../../../../core/timer.dart';

class RemainingWidget extends StatefulWidget {
  RemainingWidget({Key key, @required this.timer}) : super(key: key);

  final Timer timer;

  @override
  _RemainingWidgetState createState() => _RemainingWidgetState();
}

class _RemainingWidgetState extends State<RemainingWidget> with TickerProviderStateMixin {
  void _setState() {
    setState(() => null);
  }

  @override
  void initState() {
    super.initState();
    widget.timer.start(this);
    widget.timer.controller.addListener(_setState);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Time'),
        RemainingCounter(
          animation: new StepTween(
            begin: widget.timer.maxTimeInMilliseconds.round(),
            end: 0,
          ).animate(widget.timer.controller.value),
        ),
      ]
    );
  }

  @override
  void dispose() {
    widget.timer.controller.removeListener(_setState);
    super.dispose();
  }
}
