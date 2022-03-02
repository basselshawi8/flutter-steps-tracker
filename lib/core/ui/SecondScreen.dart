
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  var title;
  var message;
  SecondScreen({
    Key? key,
    this.title,
    this.message,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
              child: Column(
                children: <Widget>[
                  Text(title),
                  Text(message)
                ],
              ),
            )
        )
    );
  }
}
