import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/features/camera/presentation/notifiers/actions_change_notifier.dart';
import 'package:micropolis_test/main.dart';
import 'package:micropolis_test/mqtt_helper.dart';
import 'package:provider/provider.dart';

enum DriveDirection { forward, backward }

class AccelerationM1Widget extends StatefulWidget {
  @override
  _AccelerationM1WidgetState createState() {
    return _AccelerationM1WidgetState();
  }
}

class _AccelerationM1WidgetState extends State<AccelerationM1Widget>
    with SingleTickerProviderStateMixin {
  var wheelPosition = 210.h;
  AnimationController _controller;
  Animation _wheelBackAnimation;

  var _currentDriveDirection = DriveDirection.backward;
  var _emergencyBreak = false;

  @override
  void initState() {
    wheelPosition =
        _currentDriveDirection == DriveDirection.forward ? 210.h : 10.h;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _controller.addListener(() {
      setState(() {});
    });
    _wheelBackAnimation = Tween<double>(
            begin: wheelPosition, end: wheelPosition)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: Provider.of<ActionsChangeNotifier>(context).rcMode == true
            ? 40.h
            : -200.h,
        left: 80.w,
        child: Row(
          children: [
            Container(
              width: 100.w,
              height: 280.h,
              child: Stack(
                children: [
                  Positioned(
                    left: 15.w,
                    right: 15.w,
                    child: Container(
                      width: 100.w,
                      height: 280.h,
                      decoration: BoxDecoration(
                        color: CoreStyle.operationBlackColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: CoreStyle.operationBorder2Color, width: 1.w),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 30.w,
                    bottom: _currentDriveDirection == DriveDirection.backward
                        ? 0.h
                        : null,
                    top: _currentDriveDirection == DriveDirection.forward
                        ? 0.h
                        : null,
                    child: Container(
                      width: 40.w,
                      height: 90.h,
                      child: Transform.rotate(
                          angle:
                              _currentDriveDirection == DriveDirection.backward
                                  ? pi
                                  : 0,
                          child: Image.asset(IMG_UP_ARROWS)),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: _controller.isAnimating == true
                        ? _wheelBackAnimation.value
                        : wheelPosition,
                    child: GestureDetector(
                      onPanUpdate: (update) {
                        if (wheelPosition + update.delta.dy > 0.h &&
                            wheelPosition + update.delta.dy < (280 - 70).h)
                          setState(() {
                            wheelPosition += update.delta.dy;
                            var acceleration =
                                _currentDriveDirection == DriveDirection.forward
                                    ? 100 - (wheelPosition * 100 / 210.h)
                                    : (wheelPosition * 100 / 210.h);
                            print(acceleration);

                            if (_currentDriveDirection ==
                                DriveDirection.forward) {
                              mqttHelper.publishRobotDirection(
                                  RobotDirection.Forward);
                              mqttHelper.publishRobotAcceleration(
                                  acceleration.ceil());
                            } else {
                              mqttHelper
                                  .publishRobotDirection(RobotDirection.Back);
                              mqttHelper.publishRobotAcceleration(
                                  acceleration.ceil());
                            }
                          });
                      },
                      onPanEnd: (end) {
                        _wheelBackAnimation = Tween<double>(
                                begin: wheelPosition,
                                end: _currentDriveDirection ==
                                        DriveDirection.forward
                                    ? 210.h
                                    : 10.h)
                            .animate(CurvedAnimation(
                                parent: _controller, curve: Curves.easeOut));
                        _controller.value = 0;
                        _controller.forward();
                        wheelPosition =
                            _currentDriveDirection == DriveDirection.forward
                                ? 210.h
                                : 10.h;
                        mqttHelper
                            .publishRobotDirection(RobotDirection.Forward);
                      },
                      onPanCancel: () {
                        _wheelBackAnimation = Tween<double>(
                                begin: wheelPosition,
                                end: _currentDriveDirection ==
                                        DriveDirection.forward
                                    ? 210.h
                                    : 10.h)
                            .animate(CurvedAnimation(
                                parent: _controller, curve: Curves.easeOut));
                        _controller.value = 0;
                        _controller.forward();
                        wheelPosition =
                            _currentDriveDirection == DriveDirection.forward
                                ? 210.h
                                : 10.h;
                        mqttHelper
                            .publishRobotDirection(RobotDirection.Forward);
                      },
                      child: Transform.scale(
                        scale: 1.4,
                        child: Container(
                          width: 100.w,
                          height: 70.h,
                          child: Image.asset(IMG_SLIDER),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 64.w,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_currentDriveDirection == DriveDirection.forward) {
                        _currentDriveDirection = DriveDirection.backward;
                        wheelPosition = 10.h;
                      } else {
                        _currentDriveDirection = DriveDirection.forward;
                        wheelPosition = 210.h;
                      }
                    });
                  },
                  child: Container(
                    width: 110.w,
                    height: 210.h,
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                              color: Color(0xFF313131).withOpacity(0.55),
                              borderRadius: BorderRadius.circular(12.r)),
                        )),
                        Positioned(
                          child: Container(
                            width: 110.w,
                            height: 70.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFE3E3E3),
                                      Color(0xFFBCBCBC)
                                    ],
                                    begin: Alignment.topCenter,
                                    stops: [0, 0.5],
                                    end: Alignment.bottomCenter)),
                          ),
                          top: _currentDriveDirection == DriveDirection.backward
                              ? 30.h
                              : null,
                          bottom:
                              _currentDriveDirection == DriveDirection.forward
                                  ? 30.h
                                  : null,
                        ),
                        Positioned(
                          top: 47.5.h,
                          left: 40.w,
                          child: Container(
                            width: 110.w,
                            height: 50.h,
                            child: Text(
                              "R",
                              style: TextStyle(
                                  fontFamily: "Digital",
                                  fontSize: 60.sp,
                                  color: _currentDriveDirection ==
                                          DriveDirection.backward
                                      ? Color(0xFF4D4D4D)
                                      : CoreStyle.white,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 32.5.h,
                          left: 40.w,
                          child: Container(
                            width: 110.w,
                            height: 50.h,
                            child: Text(
                              "D",
                              style: TextStyle(
                                  fontFamily: "Digital",
                                  fontSize: 60.sp,
                                  color: _currentDriveDirection ==
                                          DriveDirection.forward
                                      ? Color(0xFF4D4D4D)
                                      : CoreStyle.white,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _emergencyBreak = !_emergencyBreak;
                    });
                  },
                  child: Container(
                    width: 85.w,
                    height: 85.w,
                    child: Padding(
                      padding: EdgeInsets.all(16.0.w),
                      child: Image.asset(
                        IMG_PARK,
                      ),
                    ),
                    decoration: BoxDecoration(
                        color:
                            _emergencyBreak == false ? Color(0xFFFF2750) : null,
                        boxShadow: _emergencyBreak == true
                            ? [
                                BoxShadow(
                                  color: Color(0x00000041),
                                ),
                                BoxShadow(
                                  color: Color(0xFFFF2750),
                                  spreadRadius: -1.0,
                                  blurRadius: 4.0,
                                )
                              ]
                            : null,
                        borderRadius: BorderRadius.circular(16.r)),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
