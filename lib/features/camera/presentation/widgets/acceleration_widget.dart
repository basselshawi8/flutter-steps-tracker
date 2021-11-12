import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/constants.dart';

class AccelerationWidget extends StatefulWidget {
  @override
  _AccelerationWidgetState createState() {
    // TODO: implement createState
    return _AccelerationWidgetState();
  }
}

class _AccelerationWidgetState extends State<AccelerationWidget>
    with SingleTickerProviderStateMixin {
  var wheelPosition = (140 - 35).h;
  AnimationController _controller;
  Animation _wheelBackAnimation;

  @override
  void initState() {
    // TODO: implement initState
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
        top: 300,
        left: 150.w,
        child: Container(
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
                top: 10.h,
                child: Container(
                  width: 40.w,
                  height: 90.h,
                  child: Image.asset(IMG_UP_ARROWS),
                ),
              ),
              Positioned(
                left: 30.w,
                bottom: 10.h,
                child: Container(
                  width: 40.w,
                  height: 90.h,
                  child: Transform.rotate(angle:pi, child: Image.asset(IMG_UP_ARROWS)),
                ),
              ),
              Positioned(
                left: 0,
                top:_controller.isAnimating == true ? _wheelBackAnimation.value : wheelPosition,
                child: GestureDetector(
                  onPanUpdate: (update) {
                    if (wheelPosition + update.delta.dy > 0.h &&
                        wheelPosition + update.delta.dy < (280 - 70).h)
                      setState(() {
                        wheelPosition += update.delta.dy;
                        print((wheelPosition - ((140 - 35).h))*200/(280 - 70).h);
                      });
                  },
                  onPanEnd: (end) {

                      _wheelBackAnimation = Tween<double>(
                              begin: wheelPosition, end: (140 - 35).h)
                          .animate(CurvedAnimation(
                              parent: _controller, curve: Curves.easeOut));
                      _controller.value = 0;
                      _controller.forward();
                      wheelPosition = (140 - 35).h;

                  },
                  onPanCancel: () {
                    _wheelBackAnimation = Tween<double>(
                        begin: wheelPosition, end: (140 - 35).h)
                        .animate(CurvedAnimation(
                        parent: _controller, curve: Curves.easeOut));
                    _controller.value = 0;
                    _controller.forward();
                    wheelPosition = (140 - 35).h;
                  },
                  child: Container(
                    width: 100.w,
                    height: 70.h,
                    child: Image.asset(IMG_SLIDER),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
