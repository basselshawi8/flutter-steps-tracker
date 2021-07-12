import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/constants.dart';

class IncidentsWidget extends StatefulWidget {
  @override
  _IncidentsWidgetState createState() {
    return _IncidentsWidgetState();
  }
}

class _IncidentsWidgetState extends State<IncidentsWidget> {
  var _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 512.h - 200.h,
        right: 60.w,
        child: Container(
          width: 120.w,
          height: 400.h,
          decoration: BoxDecoration(
              border: Border.all(
                  color: CoreStyle.operationBorder3Color, width: 3.w),
              color: CoreStyle.operationBlackColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    blurRadius: 40.r,
                    offset: Offset(0, 10.h),
                    color: CoreStyle.operationShadowColor)
              ]),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    _selected=0;
                  });
                },
                child: Container(
                  width: 70.h,
                  height: 70.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(IMG_BULK_CATEGORY,width: 36.w),
                    ],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: _selected == 0
                          ? CoreStyle.operationGreenContent
                          : CoreStyle.operationBlack2Color),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    _selected=1;
                  });
                },
                child: Container(
                  width: 70.h,
                  height: 70.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: _selected == 1
                          ? CoreStyle.operationGreenContent
                          : CoreStyle.operationBlack2Color),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(IMG_USER1,width: 27.w,),
                      Expanded(child: Text("7",style: TextStyle(color: CoreStyle.white,fontSize: 20.sp ),))
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    _selected=2;
                  });
                },
                child: Container(
                  width: 70.h,
                  height: 70.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: _selected == 2
                          ? CoreStyle.operationGreenContent
                          : CoreStyle.operationBlack2Color),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(IMG_USER2,width: 36.w,),
                      Expanded(child: Text("12",style: TextStyle(color: CoreStyle.white,fontSize: 20.sp ),))
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    _selected=3;
                  });
                },
                child: Container(
                  width: 70.h,
                  height: 70.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: _selected == 3
                          ? CoreStyle.operationGreenContent
                          : CoreStyle.operationBlack2Color),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(IMG_USER3,width: 36.w,),
                      Expanded(child: Text("3",style: TextStyle(color: CoreStyle.white,fontSize: 20.sp ),))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
