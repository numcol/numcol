import 'package:flutter/material.dart';
import '../../routes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.countdown);
          },
          child: Text('Play!'),
        ),
      ),
    );
  }
}
