import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/features/camera/presentation/bloc/bloc.dart';
import 'package:micropolis_test/features/camera/presentation/notifiers/actions_change_notifier.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';
import 'package:micropolis_test/features/incident/data/params/incidents_param.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/bloc.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_bloc.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_event.dart';
import 'package:micropolis_test/features/incident/presentation/screens/incidents_screen.dart';
import 'package:provider/provider.dart';

class IncidentsWidget extends StatefulWidget {
  @override
  _IncidentsWidgetState createState() {
    return _IncidentsWidgetState();
  }
}

class _IncidentsWidgetState extends State<IncidentsWidget> {
  var _selected = 0;

  @override
  void initState() {
    BlocProvider.of<IncidentsListBloc>(context)
        .add(GetIncidents(IncidentsParam(query: "classification")));
    super.initState();
  }

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
                onTap: () {
                  Provider.of<ActionsChangeNotifier>(context, listen: false)
                      .showIncidentsPanel = !Provider.of<ActionsChangeNotifier>(
                          context,
                          listen: false)
                      .showIncidentsPanel;
                  setState(() {
                    _selected = 0;
                  });
                },
                child: Container(
                  width: 70.h,
                  height: 70.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(IMG_BULK_CATEGORY, width: 36.w),
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
                onTap: () {
                  _selected = 1;
                  Navigator.of(context).pushNamed(
                      "${IncidentsScreen.routeName}?type=gamma",
                      arguments: {"location": LatLng(40.7831, -73.9712)});
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
                      Image.asset(
                        IMG_GAMMA,
                        width: 30.w,
                      ),
                      Expanded(child: FittedBox(
                        child: BlocBuilder<IncidentsListBloc, IncidentsState>(
                          buildWhen: (prev,current){
                            return prev!=current;
                          },
                          builder: (context, state) {
                            if (state is GetIncidentsSuccessState) {
                              return Text(
                                "${state.incidents.data.where((element) => element.classification == BehavioralClass.GAMMA).length}",
                                style: TextStyle(
                                    color: CoreStyle.white, fontSize: 20.sp),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selected = 2;
                    Navigator.of(context).pushNamed(
                        "${IncidentsScreen.routeName}?type=delta",
                        arguments: {"location": LatLng(40.7831, -73.9712)});
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
                      Image.asset(
                        IMG_DELTA,
                        width: 30.w,
                      ),
                      Expanded(child: FittedBox(
                        child: BlocBuilder<IncidentsListBloc, IncidentsState>(
                          buildWhen: (prev,current){
                            return prev!=current;
                          },
                          builder: (context, state) {
                            if (state is GetIncidentsSuccessState) {
                              return Text(
                                "${state.incidents.data.where((element) => element.classification == BehavioralClass.DELTA).length}",
                                style: TextStyle(
                                    color: CoreStyle.white, fontSize: 20.sp),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selected = 3;
                    Navigator.of(context).pushNamed(
                        "${IncidentsScreen.routeName}?type=beta",
                        arguments: {"location": LatLng(40.7831, -73.9712)});
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
                      Image.asset(
                        IMG_BETA,
                        width: 30.w,
                      ),
                      Expanded(child: FittedBox(
                        child: BlocBuilder<IncidentsListBloc, IncidentsState>(
                          buildWhen: (prev,current){
                            return prev!=current;
                          },
                          builder: (context, state) {
                            if (state is GetIncidentsSuccessState) {
                              return Text(
                                "${state.incidents.data.where((element) => element.classification == BehavioralClass.BETA).length}",
                                style: TextStyle(
                                    color: CoreStyle.white, fontSize: 20.sp),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
