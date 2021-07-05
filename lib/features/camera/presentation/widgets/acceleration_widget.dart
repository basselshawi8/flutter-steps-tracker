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

class _AccelerationWidgetState extends State<AccelerationWidget> {
  var wheelPosition = (83 - 15).h;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 50.w,
        child: Container(
          width: 80.w,
          height: 166.h,
          child: Stack(
            children: [
              Positioned(
                left: 15.w,
                right: 15.w,
                child: Container(
                  width: 50.w,
                  height: 166.h,
                  decoration: BoxDecoration(
                      color: CoreStyle.operationBlackColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: CoreStyle.operationBorder2Color, width: 1.w),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 30.r,
                            offset: Offset(0, 12.h),
                            color: CoreStyle.operationShadow3Color)
                      ]),

                ),
              ),
              Positioned(
                left: 27.w,
                top: 10.h,
                child: Container(
                  width: 25.5.w,
                  height: 39.h,
                  child: Image.asset(IMG_UP_ARROWS),
                ),
              ),
              Positioned(
                left: 0,
                top: wheelPosition,
                child: GestureDetector(
                  onPanUpdate: (update) {
                    if (wheelPosition + update.delta.dy > 0.h &&
                        wheelPosition + update.delta.dy < (166 - 45).h)
                      setState(() {
                        wheelPosition += update.delta.dy;
                      });
                  },
                  onPanEnd: (end) {
                    setState(() {
                      wheelPosition = (83 - 15).h;
                    });
                  },
                  onPanCancel: () {
                    setState(() {
                      wheelPosition = (83 - 15).h;
                    });
                  },
                  child: Container(
                    width: 80.w,
                    height: 50.h,
                    child: Image.asset(IMG_SLIDER),
                  ),
                ),
              ),

            ],
          ),
        ));
  }
}
