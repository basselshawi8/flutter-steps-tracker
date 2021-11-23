import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/features/incident/data/params/single_incident_param.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_bloc.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_event.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_state.dart';
import 'package:micropolis_test/features/incident/presentation/notifiers/incidents_notifier.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class IncidentActionsWidget extends StatefulWidget {
  final String incidentID;

  const IncidentActionsWidget({Key key, this.incidentID}) : super(key: key);

  @override
  _IncidentActionsWidgetState createState() {
    // TODO: implement createState
    return _IncidentActionsWidgetState();
  }
}

class _IncidentActionsWidgetState extends State<IncidentActionsWidget> {
  var _incidentBloc = IncidentsListBloc();
  var _isAsync = false;

  @override
  void dispose() {
    _incidentBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40.h,
      left: 120.w,
      right: 920.w,
      child: Container(
        height: 85.h,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
            color: CoreStyle.operationIncidentActionColor,
            borderRadius: BorderRadius.circular(20.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    IMG_DOG,
                    width: 40.w,
                    height: 40.h,
                  ),
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
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    IMG_DRONE,
                    width: 40.w,
                    height: 40.h,
                  ),
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
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    IMG_POLICE_CAR,
                    width: 40.w,
                    height: 40.h,
                  ),
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
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    IMG_LIVE,
                    width: 40.w,
                    height: 40.h,
                  ),
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

          ],
        ),
      ),
    );
  }
}
