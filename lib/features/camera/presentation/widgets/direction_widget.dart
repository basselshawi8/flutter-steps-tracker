import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/constants.dart';

enum Directions { left, top, bottom, right, none }

class DirectionWidget extends StatefulWidget {
  @override
  _DirectionWidgetState createState() {
    // TODO: implement createState
    return _DirectionWidgetState();
  }
}

class _DirectionWidgetState extends State<DirectionWidget> {
  var _currentDirection = Directions.none;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 200.w,
      top: 0,
      child: Container(
        width: 249.w,
        height: 279.w,
        child: LayoutBuilder(
          builder: (context, constrains) {
            var hCorrection = 279.w / constrains.maxHeight.w;
            var wCorrection = 249.w / constrains.maxWidth.w;
            return GestureDetector(
              onTapDown: (details) {
                print(
                    "x: ${details.localPosition.dx.w} y:${details.localPosition.dy.h}");
                if (Rect.fromPoints(Offset(25*wCorrection, 7*hCorrection), Offset(72*wCorrection, 23*hCorrection)).contains(
                    Offset(details.localPosition.dx.w,
                        details.localPosition.dy.h))) {
                  _currentDirection = Directions.top;
                } else if (Rect.fromPoints(Offset(26*wCorrection, 91*hCorrection), Offset(74.6*wCorrection, 108*hCorrection))
                    .contains(Offset(details.localPosition.dx.w,
                        details.localPosition.dy.h))) {
                  _currentDirection = Directions.bottom;
                } else if (Rect.fromPoints(Offset(8.3*wCorrection, 30*hCorrection), Offset(24.5*wCorrection, 78*hCorrection))
                    .contains(Offset(details.localPosition.dx.w,
                        details.localPosition.dy.h))) {
                  _currentDirection = Directions.left;
                } else if (Rect.fromPoints(
                        Offset(71.5*wCorrection, 32.5*hCorrection), Offset(89.3*wCorrection, 84.3*hCorrection))
                    .contains(Offset(details.localPosition.dx.w,
                        details.localPosition.dy.h))) {
                  _currentDirection = Directions.right;
                } else {
                  _currentDirection = Directions.none;
                }
                print(_currentDirection);
              },
              onTapUp: (details) {
                _currentDirection = Directions.none;
                print(_currentDirection);
              },
              onTapCancel: () {
                _currentDirection = Directions.none;
                print(_currentDirection);
              },
              child: Stack(
                children: [
                  Positioned(
                    top: 0.h,
                    left: 16.w,
                    child: Container(
                      width: 166.h,
                      height: 166.h,
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 12.w),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: CoreStyle.operationBorder2Color,
                              width: 1.w),
                          borderRadius: BorderRadius.circular(29),
                          color: CoreStyle.operationBlackColor,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 30.r,
                                offset: Offset(0, 12.h),
                                color: CoreStyle.operationShadow3Color)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Image.asset(
                              IMG_UP_ARROW,
                              width: 32.w,
                              height: 14.h,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                IMG_LEFT_ARROW,
                                width: 14.w,
                                height: 32.h,
                              ),
                              Image.asset(
                                IMG_RIGHT_ARROW,
                                width: 14.w,
                                height: 32.h,
                              ),
                            ],
                          ),
                          Image.asset(
                            IMG_DOWN_ARROW,
                            width: 32.w,
                            height: 14.h,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0 + 166.h / 2 - 130.w / 2,
                    left: 16.w + 166.h / 2 - 130.w / 2,
                    child: Center(
                      child: Image.asset(
                        IMG_WHEEL,
                        width: 130.w,
                        height: 130.w,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
//249Directions
//279
