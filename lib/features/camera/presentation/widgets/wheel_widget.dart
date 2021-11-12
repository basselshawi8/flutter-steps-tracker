import 'package:flutter/material.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';
import 'direction_widget.dart';

class WheelWidget extends StatefulWidget {
  @override
  _WheelWidgetState createState() {
    // TODO: implement createState
    return _WheelWidgetState();
  }
}

class _WheelWidgetState extends State<WheelWidget>
    with SingleTickerProviderStateMixin {
  var _currentDirection = Directions.none;
  var offset = Offset(0, 0);
  var firstFetch = false;
  var _startPanAngle = 0.0;
  var _angle = 0.0;
  Future<Offset> futureOffset;
  AnimationController _animationController;
  Animation _rotationAnimate;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _animationController.addListener(() {
      setState(() {});
    });
    futureOffset = SpUtil.getOffset(POSITION_WHEEL_WIDGET);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureOffset,
      builder: (context, snapshot) {
        if (snapshot.hasData && firstFetch == false) {
          firstFetch = true;
          offset = (snapshot.data as Offset);
        }

        return Positioned(
            top: 500.h + offset.dx,
            right: 1300.w + offset.dy,
            child: Transform.rotate(
              angle: _animationController.isAnimating == true
                  ? _rotationAnimate.value
                  : _angle,
              child: GestureDetector(
                onPanStart: (details) {
                  var deltaX = details.localPosition.dx - 150.w;
                  var deltaY = details.localPosition.dy - 150.w;
                  _startPanAngle = atan2(deltaY, deltaX);
                },
                onPanUpdate: (details) {
                  setState(() {
                    //offset = offset.translate(details.delta.dy, -details.delta.dx);
                    //SpUtil.putOffset(POSITION_WHEEL_WIDGET, offset);
                    var deltaX = details.localPosition.dx - 150.w;
                    var deltaY = details.localPosition.dy - 150.w;
                    _angle = atan2(deltaY, deltaX) - _startPanAngle;
                  });
                },
                onPanEnd: (details) {
                  _animationController.reset();
                  _rotationAnimate = Tween<double>(begin: _angle, end: 0)
                      .animate(CurvedAnimation(
                          parent: _animationController, curve: Curves.easeIn));
                  _animationController.forward();
                  _angle = 0;
                },
                onPanCancel: () {
                  _animationController.reset();
                  _rotationAnimate = Tween<double>(begin: _angle, end: 0)
                      .animate(CurvedAnimation(
                          parent: _animationController, curve: Curves.easeIn));
                  _animationController.forward();
                  _angle = 0;
                },
                child: Container(
                  width: 300.w,
                  height: 300.w,
                  decoration: BoxDecoration(
                      color: Color(0xFF1D1D1D).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(150.w),
                      border: Border.all(color: Color(0xFF6E6E6E), width: 1.w)),
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(IMG_STEER_WHEEL),
                      ),
                      Transform.translate(
                        offset: Offset(0,5.h),
                        child: Center(
                          child: Image.asset(
                            IMG_WHEEL_2,
                            width: 190.w,
                            height: 190.w,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
