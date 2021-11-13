import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/mqtt_helper.dart';

import '../../../../main.dart';

enum DrivingModes { threeSixty, manual }

var drivingMode = DrivingModes.manual;

class DrivingModeWidget extends StatefulWidget {
  @override
  _DrivingModeWidgetState createState() {
    return _DrivingModeWidgetState();
  }
}

class _DrivingModeWidgetState extends State<DrivingModeWidget> {

  @override
  void initState() {
    if (drivingMode == DrivingModes.manual) {
      mqttHelper.publishMotionMode(MotionModes.FreeMode);
    } else {
      mqttHelper.publishMotionMode(MotionModes.ThreeSixtyMode);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 50.h,
        right: 400.w,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  drivingMode = DrivingModes.manual;
                  mqttHelper.publishMotionMode(MotionModes.FreeMode);
                });
              },
              child: Container(
                width: 110.w,
                height: 110.w,
                decoration: BoxDecoration(
                    color: drivingMode == DrivingModes.manual
                        ? Color(0xFF02A76F)
                        : CoreStyle.operationBlackColor,
                    border: drivingMode == DrivingModes.manual
                        ? Border.all(color: Color(0xff02C380), width: 0.5.w)
                        : null,
                    borderRadius: BorderRadius.circular(40.r)),
                child: Transform.scale(
                  scale: 0.7,
                  child: Image.asset(
                    IMG_FREE_MODE,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  drivingMode = DrivingModes.threeSixty;
                  mqttHelper.publishMotionMode(MotionModes.ThreeSixtyMode);
                });
              },
              child: Container(
                width: 110.w,
                height: 110.w,
                decoration: BoxDecoration(
                    color: drivingMode == DrivingModes.threeSixty
                        ? Color(0xFF02A76F)
                        : CoreStyle.operationBlackColor,
                    border: drivingMode == DrivingModes.threeSixty
                        ? Border.all(color: Color(0xff02C380), width: 0.5.w)
                        : null,
                    borderRadius: BorderRadius.circular(40.r)),
                child: Transform.scale(
                  scale: 0.7,
                  child: Image.asset(
                    IMG_THREE_SIXTY_MODE,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
