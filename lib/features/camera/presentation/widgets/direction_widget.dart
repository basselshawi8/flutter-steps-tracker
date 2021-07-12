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
          height: 279.h,
          child: Stack(
            children: [
              Positioned(
                top: 0.h,
                left: 16.w,
                child: Container(
                    width: 210.w,
                    height: 166.h,
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: CoreStyle.operationBorder2Color, width: 1.w),
                      borderRadius: BorderRadius.circular(29),
                      color: CoreStyle.operationBlackColor,
                    ),
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
                    )),
              ),
              Positioned(
                top: 37.h,
                left: 70.w,
                child: Center(
                  child: Image.asset(
                    IMG_WHEEL,
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                top: 0.h,
                left: 16.w,
                child: Container(
                  width: 210.w,
                  height: 166.h,
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      var width = constraints.maxWidth;
                      var height = constraints.maxHeight;
                      return GestureDetector(
                        onTapDown: (details) {
                          print(
                              "x: ${details.localPosition.dx} y:${details.localPosition.dy}");
                          print("x: ${width} y:${height}");
                          if (Rect.fromPoints(Offset(width / 2 - width / 3.75, 0),
                                  Offset(width / 2 + width / 3.75, height / 5))
                              .contains(Offset(details.localPosition.dx,
                                  details.localPosition.dy))) {
                            _currentDirection = Directions.top;
                          } else if (Rect.fromPoints(
                                  Offset(0, height / 2 - height / 3.75),
                                  Offset(width / 6, height / 2 + height / 3.75))
                              .contains(Offset(details.localPosition.dx,
                                  details.localPosition.dy))) {
                            _currentDirection = Directions.left;
                          } else if (Rect.fromPoints(
                                  Offset(width - width / 6,
                                      height / 2 - height / 3.75),
                                  Offset(width, height / 2 + height / 3.75))
                              .contains(Offset(details.localPosition.dx,
                                  details.localPosition.dy))) {
                            _currentDirection = Directions.right;
                          } else if (Rect.fromPoints(
                                  Offset(width / 2 - width / 3.75,
                                      height - height / 6),
                                  Offset(width / 2 + width / 3.75, height))
                              .contains(Offset(details.localPosition.dx,
                                  details.localPosition.dy))) {
                            _currentDirection = Directions.bottom;
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
                      );
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
//249Directions
//279
