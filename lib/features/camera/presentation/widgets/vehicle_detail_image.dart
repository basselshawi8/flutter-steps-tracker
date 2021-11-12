import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';

class VehicleDetailWidget extends StatefulWidget {
  final String speed;
  final int battery;

  const VehicleDetailWidget({Key key, this.speed, this.battery})
      : super(key: key);

  @override
  _VehicleDetailWidgetState createState() {
    return _VehicleDetailWidgetState();
  }
}

class _VehicleDetailWidgetState extends State<VehicleDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 300.h,
        left: 250.w,
        child: Container(
          width: 450.w,
          height: 120.h,
          child: Stack(
            children: [
              Positioned(
                top: 10.h,
                bottom: 10.h,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF313131).withOpacity(0.55),
                      borderRadius: BorderRadius.circular(40.r)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 130.w,
                          decoration: BoxDecoration(
                              color: Color(0xFFFF2750),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r))),
                          child: Center(
                            child: Image.asset(
                              IMG_STOP,
                              width: 70.w,
                              height: 70.w,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 130.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 12.h,),
                            Image.asset(
                              IMG_BATTERY,
                              width: 60.w,

                            ),
                            SizedBox(height: 8.h,),
                            Text(
                              "${widget.battery}%",
                              style: TextStyle(
                                  color: CoreStyle.white.withOpacity(0.3),
                                  fontFamily: CoreStyle.fontWithWeight(
                                      FontWeight.w400)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  left: 225.w - 65.w,
                  child: Container(
                    width: 130.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 8, 8, 8),
                        borderRadius: BorderRadius.circular(14.r)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          widget.speed ?? "0",
                          style: TextStyle(
                              fontFamily: "Digital",
                              fontStyle: FontStyle.italic,
                              fontSize: 60.sp,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF01A56D)),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          "Km",
                          style: TextStyle(
                              color: CoreStyle.white.withOpacity(0.27),
                              fontSize: 24.sp,
                              fontFamily:
                                  CoreStyle.fontWithWeight(FontWeight.w400)),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}