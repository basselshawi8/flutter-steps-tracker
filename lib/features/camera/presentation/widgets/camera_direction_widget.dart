import 'package:flutter/material.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CameraDirectionWidget extends StatefulWidget {
  @override
  _CameraDirectionWidgetState createState() {
    // TODO: implement createState
    return _CameraDirectionWidgetState();
  }
}

class _CameraDirectionWidgetState extends State<CameraDirectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 512.h - 180.w,
        right: 200.w,
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
              Positioned(
                bottom: 70.w,
                left: 60.w,
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
              Positioned(
                bottom: 70.w,
                right: 60.w,
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
            ],
          ),
        ));
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
