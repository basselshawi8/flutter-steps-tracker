import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';

const int _DefaultDashes = 20;
const Color _DefaultColor = Color(0);
const double _DefaultGapSize = 3.0;
const double _DefaultStrokeWidth = 5;

class DashedCircle extends StatelessWidget {
  final int dashes;
  final Color color;
  final double gapSize;
  final double strokeWidth;
  final int value;
  final Widget child;

  DashedCircle(
      {this.child,
        this.dashes = _DefaultDashes,
        this.color = _DefaultColor,
        this.value,
        this.gapSize = _DefaultGapSize,
        this.strokeWidth = _DefaultStrokeWidth});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedCirclePainter(
          dashes: dashes,
          color: color,
          gapSize: gapSize,
          value: value,
          strokeWidth: strokeWidth),
      child: child,
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final int dashes;
  final Color color;
  final double gapSize;
  final double strokeWidth;
  final int value;

  DashedCirclePainter(
      {this.dashes = _DefaultDashes,
        this.color = _DefaultColor,
        this.gapSize = _DefaultGapSize,
        this.value,
        this.strokeWidth = _DefaultStrokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final double gap = pi / 180 * gapSize;
    final double singleAngle = (pi * 2) / dashes;

    var colorTween = ColorTween(begin: CoreStyle.operationRoseColor,end: CoreStyle.operationRedColor);

    for (int i = 0; i < dashes; i++) {
      if ((i/dashes*100)<value) {
        final Paint paint = Paint()
          ..color = colorTween.lerp(min((i + 1) / dashes, 1))
          ..strokeWidth = _DefaultStrokeWidth
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

        canvas.drawArc(Offset.zero & size, gap + singleAngle * i - pi / 2,
            singleAngle - gap * 2, false, paint);
      }
      else {
        final Paint paint = Paint()
          ..color = CoreStyle.operationDashColor
          ..strokeWidth = _DefaultStrokeWidth
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

        canvas.drawArc(Offset.zero & size, gap + singleAngle * i - pi / 2,
            singleAngle - gap * 2, false, paint);
      }
    }
  }

  @override
  bool shouldRepaint(DashedCirclePainter oldDelegate) {
    return dashes != oldDelegate.dashes || color != oldDelegate.color;
  }
}
