import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';

class IncidentActionsWidget extends StatefulWidget {
  @override
  _IncidentActionsWidgetState createState() {
    // TODO: implement createState
    return _IncidentActionsWidgetState();
  }
}

class _IncidentActionsWidgetState extends State<IncidentActionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 950.h,
      bottom: 40.h,
      left: 120.w,
      right: 920.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
            color: CoreStyle.operationIncidentActionColor,
            borderRadius: BorderRadius.circular(20.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(IMG_DOG,width: 40.w,height: 40.h,),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "K9 Follow",
                    style: TextStyle(
                        color: CoreStyle.operationLightTextColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: (){},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(IMG_DRONE,width: 40.w,height: 40.h,),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Drone Chase",
                    style: TextStyle(
                        color: CoreStyle.operationLightTextColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: (){},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(IMG_POLICE_CAR,width: 40.w,height: 40.h,),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Nearest Patrol",
                    style: TextStyle(
                        color: CoreStyle.operationLightTextColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: (){

              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(IMG_LIVE,width: 40.w,height: 40.h,),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Live Report To",
                    style: TextStyle(
                        color: CoreStyle.operationLightTextColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),

            Container(
              height: 50.h,
              width: 170.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.r),
                color: CoreStyle.operationRose2Color
              ),
              child: Center(
                child: Text(
                  "Dismiss",
                  style: TextStyle(
                      color: CoreStyle.operationLightTextColor,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
