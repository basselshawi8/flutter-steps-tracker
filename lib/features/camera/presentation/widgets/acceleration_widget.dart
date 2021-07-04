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
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: wheelPosition,
                child: GestureDetector(
                  onPanUpdate: (update) {
                    if (wheelPosition + update.delta.dy > 5.h &&
                        wheelPosition + update.delta.dy < (166 - 40).h)
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
                    width: 50.w,
                    height: 30.h,
                    child: Image.asset(IMG_SLIDER),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
