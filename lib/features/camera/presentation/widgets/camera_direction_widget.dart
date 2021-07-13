import 'package:flutter/material.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'direction_widget.dart';

class CameraDirectionWidget extends StatefulWidget {
  @override
  _CameraDirectionWidgetState createState() {
    // TODO: implement createState
    return _CameraDirectionWidgetState();
  }
}

class _CameraDirectionWidgetState extends State<CameraDirectionWidget> {
  var _currentDirection = Directions.none;
  var offset = Offset(0, 0);
  var firstFetch = false;
  Future<Offset> futureOffset;

  @override
  void initState() {
    futureOffset = SpUtil.getOffset("cameraDirectionWidget");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureOffset,
      builder: (context,snapshot){

        if (snapshot.hasData&&firstFetch == false) {
          firstFetch = true;
          offset =  (snapshot.data as Offset);
        }

        return Positioned(
            top: 512.h - 180.w + offset.dx,
            right: 200.w + offset.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  offset = offset.translate(details.delta.dy, -details.delta.dx);
                  SpUtil.putOffset("cameraDirectionWidget", offset);
                });
              },
              child: Container(
                width: 360.w,
                height: 360.w,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        IMG_CAMERA_MOVEMENT,
                      ),
                    ),
                    Positioned(
                      top: 88.5.w,
                      left: 97.5.w,
                      child: Image.asset(
                        IMG_WHEEL_GREY,
                        width: 165.w,
                        height: 165.w,
                      ),
                    ),
                    Positioned.fill(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          var width = constraints.maxWidth;
                          var height = constraints.maxHeight;
                          return GestureDetector(
                            onTapDown: (details) {
                              print(
                                  "x: ${details.localPosition.dx} y:${details.localPosition.dy}");
                              print("x: ${width} y:${height}");
                              if (details.localPosition.dy < height / 3.5) {
                                _currentDirection = Directions.top;
                              } else if (details.localPosition.dx < width / 3.5) {
                                _currentDirection = Directions.left;
                              } else if (details.localPosition.dx > width * 0.65) {
                                _currentDirection = Directions.right;
                              } else if (details.localPosition.dy > height * 0.65) {
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
                    Positioned(
                      bottom: 70.w,
                      left: 60.w,
                      child: GestureDetector(

                        onTap: () {
                          print("minus");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: CoreStyle.operationBlack2Color,
                              borderRadius: BorderRadius.all(Radius.circular(14)),
                              boxShadow: [
                                BoxShadow(
                                    color: CoreStyle.operationShadowColor,
                                    blurRadius: 30.r,
                                    offset: Offset(0, 12.h))
                              ]),
                          width: 68.w,
                          height: 68.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                ),
                                color: CoreStyle.operationBorder2Color,
                                height: 4.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 70.w,
                      right: 60.w,
                      child: GestureDetector(
                        onTap: () {
                          print("plus");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: CoreStyle.operationBlack2Color,
                              borderRadius: BorderRadius.all(Radius.circular(14)),
                              boxShadow: [
                                BoxShadow(
                                    color: CoreStyle.operationShadowColor,
                                    blurRadius: 30.r,
                                    offset: Offset(0, 12.h))
                              ]),
                          width: 68.w,
                          height: 68.w,
                          child: Container(
                            width: 68.w,
                            height: 68.w,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16.w,
                                            ),
                                            color: CoreStyle.operationBorder2Color,
                                            height: 4.h,
                                          )
                                        ])),
                                Positioned.fill(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 16.w,
                                          ),
                                          color: CoreStyle.operationBorder2Color,
                                          width: 4.h,
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },

    );
  }
}
/*Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w,),
                          color: CoreStyle.operationBorder2Color,
                          height: 4.h,

                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 16.w,),
                              color: CoreStyle.operationBorder2Color,
                              width: 4.h,

                            ),
                          ],
                        )
                      ],
                    )*/
