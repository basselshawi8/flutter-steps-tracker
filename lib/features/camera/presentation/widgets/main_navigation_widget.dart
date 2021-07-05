import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/constants.dart';

import 'acceleration_widget.dart';
import 'camera_direction_widget.dart';
import 'direction_widget.dart';

class MainNavigationWidget extends StatefulWidget {
  @override
  _MainNavigationWidgetState createState() {
    // TODO: implement createState
    return _MainNavigationWidgetState();
  }
}

class _MainNavigationWidgetState extends State<MainNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: -20.h,
        left: (1920 / 2 - 225).w,
        child: Container(
          width: 520.w,
          height: 240.h,
          child: Stack(
            children: [
              Positioned(
                top: 20.h,
                left: 0,
                right: 0,
                bottom: 92.5.h,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF232323),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 40,
                            offset: Offset(0, 10),
                            color: CoreStyle.operationShadow2Color)
                      ]),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  width: 450.w,
                  height: 170.h,
                  child: Stack(
                    children: [AccelerationWidget()],
                  ),
                ),
              ),
              Positioned(
                top: 55.h,
                left: 165.w,
                child: Container(
                  width: 1.w,
                  height: 60.h,
                  color: CoreStyle.operationBorder2Color,
                ),
              ),
              DirectionWidget(),
              Positioned(
                top: 70.h,
                left: 455.w,
                child:Image.asset(IMG_BULK_CATEGORY,width: 36.w,height: 36.w,)
              ),

            ],
          ),
        ));
  }
}
