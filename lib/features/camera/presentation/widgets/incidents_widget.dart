import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/camera/presentation/bloc/bloc.dart';
import 'package:micropolis_test/features/camera/presentation/notifiers/actions_change_notifier.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';
import 'package:micropolis_test/features/incident/data/params/incidents_param.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/bloc.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_bloc.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_event.dart';
import 'package:micropolis_test/features/incident/presentation/notifiers/incidents_notifier.dart';
import 'package:micropolis_test/features/incident/presentation/screens/incidents_screen.dart';
import 'package:provider/provider.dart';
import 'package:micropolis_test/features/incident/presentation/widgets/incidents_widget.dart';

class IncidentsWidget extends StatefulWidget {
  @override
  _IncidentsWidgetState createState() {
    return _IncidentsWidgetState();
  }
}

class _IncidentsWidgetState extends State<IncidentsWidget> {
  var _selected = 0;

  var _cancelToken = CancelToken();

  @override
  void initState() {
    BlocProvider.of<IncidentsListBloc>(context)
        .add(GetIncidentClassification(NoParams(cancelToken: _cancelToken)));
    super.initState();
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 512.h - 200.h,
        right: 360.w,
        child: Consumer<IncidentsChangeNotifier>(
          builder: (context, state, _) {
            if (state.updateHomeIncidentClassifications == true) {
              BlocProvider.of<IncidentsListBloc>(context).add(
                  GetIncidentClassification(
                      NoParams(cancelToken: _cancelToken)));
            }
            return Container(
              width: 600.w,
              height: 85.h,
              decoration: BoxDecoration(
                  color: CoreStyle.operationBlackColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 40.r,
                        offset: Offset(0, 10.h),
                        color: CoreStyle.operationShadowColor)
                  ]),
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selected = 3;
                        incidentsList = [];
                        Navigator.of(context).pushNamed(
                            "${IncidentsScreen.routeName}?type=beta",
                            arguments: {"location": LatLng(40.7831, -73.9712)});
                      });
                    },
                    child: Container(
                      width: 70.h,
                      height: 85.h,

                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  IMG_BETA,
                                  color: Color.fromARGB(255, 83, 83, 83),
                                  width: 50.w,
                                ),
                                BlocBuilder<IncidentsListBloc, IncidentsState>(
                                  buildWhen: (prev, current) {
                                    return prev != current;
                                  },
                                  builder: (context, state) {
                                    if (state
                                        is GetIncidentsClassificationSuccessState) {
                                      var classifications = state
                                          .classifications.data
                                          .where((element) =>
                                              element.id.classification
                                                  .toLowerCase()
                                                  .contains("beta") ==
                                              true);
                                      return Expanded(
                                        child: FittedBox(
                                          child: Text(
                                            "${classifications.length == 0 ? 0 : classifications?.first?.count ?? 0}",
                                            style: TextStyle(
                                                color: CoreStyle.white,
                                                fontSize: 20.sp),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        width: 20.w,
                                        height: 20.w,
                                        child: Center(
                                          child: CircularProgressIndicator(strokeWidth: 2,),
                                        ),
                                      );
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              bottom: -13.h,
                              left: 10.w,
                              right: 10.w,
                              child: Container(

                                height: 20.h,
                                decoration: BoxDecoration(
                                    color: Color(0xFFBD5CF0),
                                    borderRadius: BorderRadius.circular(8.r)),
                              ))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selected = 2;
                        incidentsList = [];
                        Navigator.of(context).pushNamed(
                            "${IncidentsScreen.routeName}?type=delta",
                            arguments: {"location": LatLng(40.7831, -73.9712)});
                      });
                    },
                    child: Container(
                      width: 70.h,
                      height: 85.h,

                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  IMG_DELTA,
                                  color: Color.fromARGB(255, 83, 83, 83),
                                  width: 50.w,
                                ),
                                BlocBuilder<IncidentsListBloc, IncidentsState>(
                                  buildWhen: (prev, current) {
                                    return prev != current;
                                  },
                                  builder: (context, state) {
                                    if (state
                                        is GetIncidentsClassificationSuccessState) {
                                      var classifications = state.classifications.data
                                          .where((element) =>
                                              element.id.classification
                                                  .toLowerCase()
                                                  .contains("delta") ==
                                              true);

                                      return Expanded(
                                        child: FittedBox(
                                          child: Text(
                                            "${classifications.length == 0 ? 0 : classifications?.first?.count ?? 0}",
                                            style: TextStyle(
                                                color: CoreStyle.white,
                                                fontSize: 20.sp),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        width: 20.w,
                                        height: 20.w,
                                        child: Center(
                                          child: CircularProgressIndicator(strokeWidth: 2,),
                                        ),
                                      );
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              bottom: -13.h,
                              left: 10.w,
                              right: 10.w,
                              child: Container(

                                height: 20.h,
                                decoration: BoxDecoration(
                                    color: Color(0xFFF0AC5C),
                                    borderRadius: BorderRadius.circular(8.r)),
                              ))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _selected = 1;
                      incidentsList = [];
                      Navigator.of(context).pushNamed(
                          "${IncidentsScreen.routeName}?type=gamma",
                          arguments: {"location": LatLng(40.7831, -73.9712)});
                    },
                    child: Container(
                      width: 70.h,
                      height: 85.h,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  IMG_GAMMA,
                                  width: 50.w,
                                  color: Color.fromARGB(255, 83, 83, 83),
                                ),
                                BlocBuilder<IncidentsListBloc, IncidentsState>(
                                  buildWhen: (prev, current) {
                                    return prev != current;
                                  },
                                  builder: (context, state) {
                                    if (state
                                        is GetIncidentsClassificationSuccessState) {
                                      var classifications = state.classifications.data
                                          .where((element) =>
                                              element.id.classification
                                                  .toLowerCase()
                                                  .contains("gamma") ==
                                              true);
                                      return Expanded(
                                        child: FittedBox(
                                          child: Text(
                                            "${classifications.length == 0 ? 0 : classifications?.first?.count ?? 0}",
                                            style: TextStyle(
                                                color: CoreStyle.white,
                                                fontSize: 20.sp),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        width: 20.w,
                                        height: 20.w,
                                        child: Center(
                                          child: CircularProgressIndicator(strokeWidth: 2,),
                                        ),
                                      );
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              bottom: -13.h,
                              left: 10.w,
                              right: 10.w,
                              child: Container(

                                height: 20.h,
                                decoration: BoxDecoration(
                                    color: Color(0xFFF05C5C),
                                    borderRadius: BorderRadius.circular(8.r)),
                              ))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<ActionsChangeNotifier>(context, listen: false)
                              .showIncidentsPanel =
                          !Provider.of<ActionsChangeNotifier>(context,
                                  listen: false)
                              .showIncidentsPanel;
                      setState(() {
                        _selected = 0;
                      });
                    },
                    child: Container(
                      width: 60.h,
                      height: 60.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(IMG_BULK_CATEGORY, width: 50.w),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
