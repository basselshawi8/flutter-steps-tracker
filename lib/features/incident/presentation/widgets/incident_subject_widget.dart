import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';

import 'dashed_circle.dart';

class IncidentSubjectWidget extends StatefulWidget {
  @override
  _IncidentSubjectWidgetState createState() {
    // TODO: implement createState
    return _IncidentSubjectWidgetState();
  }
}

class _IncidentSubjectWidgetState extends State<IncidentSubjectWidget> {
  var name = "Bassel Shawi";
  var incidentType = "Facial Recognition";
  var incidentAction = "Kidnapping";
  var carID = "DPNP Mono 208";

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 1920.w - 800.w,
        bottom: 0,
        right: 400.w,
        child: Container(
          color: Color.fromARGB(255, 20, 20, 20),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Suspect Name",
                style: TextStyle(
                    color: CoreStyle.operationLightTextColor.withOpacity(0.6),
                    fontWeight: FontWeight.w200,
                    fontSize: 15.sp),
              ),
              Text(
                name,
                style: TextStyle(
                    color: CoreStyle.operationLightTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 24.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 215.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Color.fromARGB(255, 25, 25, 25)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    DashedCircle(
                      dashes: 12,
                      gapSize: 10,
                      strokeWidth: 20,
                      value: 63,
                      color: CoreStyle.operationRedColor,
                      child: Container(
                          width: 120.w,
                          height: 120.w,
                          child: Center(
                              child: Text(
                            "${62}",
                            style: TextStyle(color: CoreStyle.white),
                          ))),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      incidentType,
                      style: TextStyle(
                          color: CoreStyle.operationLightTextColor
                              .withOpacity(0.4),
                          fontWeight: FontWeight.w200,
                          fontSize: 14.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 40.h,
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                          color: CoreStyle.operationIncidentItemListBlackColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          incidentAction,
                          style: TextStyle(
                              color: CoreStyle.operationLightTextColor,
                              fontWeight: FontWeight.w300,
                              fontSize: 20.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
              Container(
                  height: 215.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Color.fromARGB(255, 25, 25, 25)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h,),
                        Text("Car ID",
                            style: TextStyle(
                              color: CoreStyle.operationLightTextColor
                                  .withOpacity(0.4),
                              fontWeight: FontWeight.w200,
                              fontSize: 14.sp,
                            )),
                        Text(
                          carID,
                          style: TextStyle(
                              color: CoreStyle.operationLightTextColor,
                              fontWeight: FontWeight.w300,
                              fontSize: 18.sp),
                        ),
                        Text("ID Type",
                            style: TextStyle(
                              color: CoreStyle.operationLightTextColor
                                  .withOpacity(0.4),
                              fontWeight: FontWeight.w200,
                              fontSize: 14.sp,
                            )),
                        Text(
                          carID,
                          style: TextStyle(
                              color: CoreStyle.operationLightTextColor,
                              fontWeight: FontWeight.w300,
                              fontSize: 18.sp),
                        ),
                        Text("ID No",
                            style: TextStyle(
                              color: CoreStyle.operationLightTextColor
                                  .withOpacity(0.4),
                              fontWeight: FontWeight.w200,
                              fontSize: 14.sp,
                            )),
                        Text(
                          carID,
                          style: TextStyle(
                              color: CoreStyle.operationLightTextColor,
                              fontWeight: FontWeight.w300,
                              fontSize: 18.sp),
                        ),
                        Text("Nationality",
                            style: TextStyle(
                              color: CoreStyle.operationLightTextColor
                                  .withOpacity(0.4),
                              fontWeight: FontWeight.w200,
                              fontSize: 14.sp,
                            )),
                        Text(
                          carID,
                          style: TextStyle(
                              color: CoreStyle.operationLightTextColor,
                              fontWeight: FontWeight.w300,
                              fontSize: 18.sp),
                        ),
                        Text("Location",
                            style: TextStyle(
                              color: CoreStyle.operationLightTextColor
                                  .withOpacity(0.4),
                              fontWeight: FontWeight.w200,
                              fontSize: 14.sp,
                            )),
                        Text(
                          carID,
                          style: TextStyle(
                              color: CoreStyle.operationLightTextColor,
                              fontWeight: FontWeight.w300,
                              fontSize: 18.sp),
                        )
                      ],
                    ),
                  ))
            ]),
          ),
        ));
  }
}
