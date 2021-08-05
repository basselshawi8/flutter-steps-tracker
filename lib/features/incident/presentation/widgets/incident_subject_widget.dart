import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/features/incident/presentation/notifiers/incidents_notifier.dart';
import 'package:provider/provider.dart';
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
  var idType = "Passport";
  var idNo = "44322DFG113";
  var nationality = "Russian";
  var location = "Dubai";
  var suspectLevel = "E";
  var criminalResult = "Wanted";

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 1920.w - 800.w,
        bottom: 0,
        right: 400.w,
        child: Consumer<IncidentsChangeNotifier>(
          builder: (context,state,_){

            if (state.currentIncident!=null) {
              name = state.currentIncident.incidentDesc;
              carID = state.currentIncident.vehicleId;
              suspectLevel = state.currentIncident.incidentType;
              idNo = state.currentIncident.id;
              location = "${state.currentIncident.latitude},${state.currentIncident.longitude}";
            }
            return Container(
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
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Color.fromARGB(255, 25, 25, 25)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
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
                            SizedBox(
                              height: 5.h,
                            ),
                            Text("ID Type",
                                style: TextStyle(
                                  color: CoreStyle.operationLightTextColor
                                      .withOpacity(0.4),
                                  fontWeight: FontWeight.w200,
                                  fontSize: 14.sp,
                                )),
                            Text(
                              idType,
                              style: TextStyle(
                                  color: CoreStyle.operationLightTextColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18.sp),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text("ID No",
                                style: TextStyle(
                                  color: CoreStyle.operationLightTextColor
                                      .withOpacity(0.4),
                                  fontWeight: FontWeight.w200,
                                  fontSize: 14.sp,
                                )),
                            Text(
                              idNo,
                              style: TextStyle(
                                  color: CoreStyle.operationLightTextColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18.sp),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text("Nationality",
                                style: TextStyle(
                                  color: CoreStyle.operationLightTextColor
                                      .withOpacity(0.4),
                                  fontWeight: FontWeight.w200,
                                  fontSize: 14.sp,
                                )),
                            Text(
                              nationality,
                              style: TextStyle(
                                  color: CoreStyle.operationLightTextColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18.sp),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text("Location",
                                style: TextStyle(
                                  color: CoreStyle.operationLightTextColor
                                      .withOpacity(0.4),
                                  fontWeight: FontWeight.w200,
                                  fontSize: 14.sp,
                                )),
                            Text(
                              location,
                              style: TextStyle(
                                  color: CoreStyle.operationLightTextColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18.sp),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Color.fromARGB(255, 25, 25, 25)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Suspect Level",
                                    style: TextStyle(
                                      color: CoreStyle.operationLightTextColor
                                          .withOpacity(0.4),
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14.sp,
                                    )),
                                Container(
                                  width: 40.w,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                      color: CoreStyle.operationDashColor,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4.r))),
                                  child: Center(
                                    child: Text(
                                      suspectLevel,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w200,
                                          fontSize: 15.sp),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Criminal Login Result",
                                    style: TextStyle(
                                      color: CoreStyle.operationLightTextColor
                                          .withOpacity(0.4),
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14.sp,
                                    )),
                                Container(
                                  width: 80.w,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                      color: CoreStyle.operationDashColor,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4.r))),
                                  child: Center(
                                    child: Text(
                                      criminalResult,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w200,
                                          fontSize: 15.sp),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      child: SizedBox(
                        height: 10.h,
                      )),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      height: 42.h,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: CoreStyle.operationDarkGreen,
                          borderRadius: BorderRadius.circular(6.r)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              IMG_PIN,
                              width: 20.w,
                              height: 20.h,
                            ),
                            Text(
                              "Pin To Top",
                              style: TextStyle(
                                  color: CoreStyle.operationLightTextColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w200),
                            ),
                            Container(
                              width: 10,
                              height: 10,
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      height: 42.h,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: CoreStyle.operationDarkGreen,
                          borderRadius: BorderRadius.circular(6.r)),
                      child: Center(
                        child: Text(
                          "Suspect Data",
                          style: TextStyle(
                              color: CoreStyle.operationLightTextColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w200),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      height: 42.h,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: CoreStyle.operationDarkGreen,
                          borderRadius: BorderRadius.circular(6.r)),
                      child: Center(
                        child: Text(
                          "Criminal Logic Report",
                          style: TextStyle(
                              color: CoreStyle.operationLightTextColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w200),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      height: 42.h,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: CoreStyle.operationDarkGreen,
                          borderRadius: BorderRadius.circular(6.r)),
                      child: Center(
                        child: Text(
                          "Upgrade",
                          style: TextStyle(
                              color: CoreStyle.operationLightTextColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w200),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ]),
              ),
            );
          },
        ));
  }
}
