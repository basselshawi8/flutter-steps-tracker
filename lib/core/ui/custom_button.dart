import 'dart:ui';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;

  const CustomButton({this.text, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Center(
        child: Container(
          height: 50,
          width: CoreStyle.setWidthPercentage(35, context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
              color: color??Theme.of(context).primaryColor

          ),
          child: RaisedButton(
            color: color??Theme.of(context).primaryColor,
            splashColor: color??Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: FittedBox(
              child: Text(
                text,
                style: CommonTextStyle.normalTextWhite,
              ),
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}