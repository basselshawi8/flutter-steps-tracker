import 'package:flutter/material.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/main.dart';
import 'package:micropolis_test/mqtt_helper.dart';
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
            bottom: 32.h,
            right: 50.w,
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
                    var delta = atan2(deltaY, deltaX) - _startPanAngle;
                    delta = delta.abs() > 1 ? (0.007 * delta.sign) : delta;

                    if (_angle + delta > 3.14 || _angle + delta < -3.14) {
                      return;
                    }
                    _angle += delta;

                    _startPanAngle = atan2(deltaY, deltaX);

                    if (_angle < -0.3) {
                      mqttHelper.publishRobotDirection(RobotDirection.Left);
                    } else if (_angle > 0.3 && _angle < 1.5) {
                      mqttHelper.publishRobotDirection(RobotDirection.Right);
                    }
                  });
                },
                onPanEnd: (details) {
                  _animationController.reset();
                  _rotationAnimate = Tween<double>(begin: _angle, end: 0)
                      .animate(CurvedAnimation(
                          parent: _animationController, curve: Curves.easeIn));
                  _animationController.forward();
                  _angle = 0;
                  mqttHelper.publishRobotDirection(RobotDirection.Forward);
                },
                onPanCancel: () {
                  _animationController.reset();
                  _rotationAnimate = Tween<double>(begin: _angle, end: 0)
                      .animate(CurvedAnimation(
                          parent: _animationController, curve: Curves.easeIn));
                  _animationController.forward();
                  _angle = 0;
                  mqttHelper.publishRobotDirection(RobotDirection.Forward);
                },
                child: Container(
                  width: 270.h,
                  height: 270.h,
                  decoration: BoxDecoration(
                      color: Color(0xFF1D1D1D).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(135.h),
                      border: Border.all(color: Color(0xFF6E6E6E), width: 1.w)),
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(IMG_STEER_WHEEL),
                      ),
                      Transform.translate(
                        offset: Offset(0, 7.h),
                        child: Center(
                          child: Image.asset(
                            IMG_WHEEL_2,
                            width: 175.h,
                            height: 175.h,
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
