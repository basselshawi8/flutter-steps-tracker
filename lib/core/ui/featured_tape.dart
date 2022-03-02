import 'dart:ui';

import 'package:micropolis_test/core/Common/Common.dart';
import 'package:flutter/material.dart';

class FeaturedTape extends StatelessWidget {
  final Widget? child;
  final String message;
  final double topPosition;
  final bool? isLeft;
  final Color? tapeColor;
  final textStyle;
  final bool? showTape;

  const FeaturedTape(
      {Key? key,
      this.child,
      required this.message,
      required this.topPosition,
      this.isLeft,
      this.tapeColor,
      this.textStyle,
      this.showTape})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child ?? Container(),
        showTape == null || showTape!
            ? Positioned(
                top: topPosition ?? 20,
          left: isLeft == null || isLeft! ? 0 : null,
          right: isLeft == null || isLeft! ? null : 0,
                child: ClipPath(
                  clipper: TapeClipper(isLeft ?? false),
                  child: Container(
                    height: 30,
                    width: 100,
                    color: tapeColor ?? Colors.red.withAlpha(200),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          padding: EdgeInsets.only(
                            left: isLeft == null || isLeft!
                                ? 10
                                : constraints.maxWidth / 4,
                            bottom: 6,
                            right: isLeft == null || isLeft!
                                ? constraints.maxWidth / 4
                                : 10,
                          ),
                          child: Center(
                            child: Text(
                              message ?? 'Special offer',
                              overflow: TextOverflow.ellipsis,
                              style: textStyle ?? CommonTextStyle.miniTextWhite,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}

class TapeClipper extends CustomClipper<Path> {
  final bool isLeft;

  TapeClipper(this.isLeft);

  @override
  Path getClip(Size size) {
    Path path = Path();
    if (isLeft == null || isLeft) {
      path.lineTo(0, 6);
      path.quadraticBezierTo(0, 0, 10, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width - (size.width / 7), size.height / 2 - 3);
      path.lineTo(size.width, size.height - 6);
      path.lineTo(10, size.height - 6);
      path.quadraticBezierTo(0, size.height - 6, 0, size.height);
    } else {
      path.lineTo(size.width / 7, size.height / 2 - 3);
      path.lineTo(0, size.height - 6);
      path.lineTo(size.width - 10, size.height - 6);
      path.quadraticBezierTo(
          size.width - 5, size.height - 6, size.width, size.height);
      path.lineTo(size.width, 6);
      path.quadraticBezierTo(size.width, 0, size.width - 10, 0);
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
