import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';
import 'package:micropolis_test/features/incident/data/params/single_incident_param.dart';
import 'package:micropolis_test/features/incident/data/params/subject_param.dart';
import 'package:micropolis_test/features/incident/data/params/update_incident_param.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_bloc.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_event.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_state.dart';
import 'package:micropolis_test/features/incident/presentation/notifiers/incidents_notifier.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'dashed_circle.dart';
import 'package:geocoding/geocoding.dart';

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
  var idType = "Pjassport";
  var idNo = "44322DFG113";
  Future<String> location;
  var nationality = "";
  var suspectLevel = "E";
  var criminalResult = "Wanted";
  var _incidentID = "";
  var _incidentsBloc = IncidentsListBloc();
  var _isAsync = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _incidentsBloc.close();
    // TODO: implement dispose
    super.dispose();
  }

  Future<String> _getLocation(String lat, String long) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
        double.tryParse(lat), double.tryParse(long));
    if (placeMarks != null && placeMarks.isNotEmpty) {
      return "${placeMarks?.first?.locality}\n${placeMarks?.first?.name}";
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 80.h,
        left: 1920.w - 800.w,
        bottom: 0,
        right: 170.w,
        child: Consumer<IncidentsChangeNotifier>(
          builder: (context, state, _) {
            if (state.currentIncident != null) {
              if (_incidentID != state.currentIncident.id) {
                _isAsync = true;
                _incidentsBloc.add(GetSubjects(
                    SubjectsParam(ids: state.currentIncident.personId.perId)));
              }

              _incidentID = state.currentIncident.id;
              incidentType = state.currentIncident.classification == "F"
                  ? "Facial Recognition"
                  : "Behavioral Analysis";
              carID =
                  state.currentIncident.vehicle.vehicleVehicleId.toUpperCase();
              suspectLevel =
                  state.currentIncident.isWanted ? "Wanted" : "Not Wanted";
              location = _getLocation(state.currentIncident.latitude,
                  state.currentIncident.longitude);
            }
            return BlocListener<IncidentsListBloc, IncidentsState>(
              bloc: _incidentsBloc,
              listenWhen: (prev, current) => prev != current,
              listener: (context, state) {
                if (state is GetSubjectsSuccessState) {
                  setState(() {
                    Provider.of<IncidentsChangeNotifier>(context, listen: false)
                        .suspects = state.subjects;

                    if (state.subjects.data.length > 0) {
                      name =
                          "${state.subjects.data.first.name} ${state.subjects.data.first.surname}";
                      idType = state.subjects.data.first.idType.toUpperCase();
                      nationality =
                          state.subjects.data.first.nationality.nationality;
                      idNo = state.subjects.data.first.idNo;
                    }
                    _isAsync = false;
                  });
                } else if (state is UpgradeIncidentSuccessState) {
                  setState(() {
                    _isAsync = false;
                  });
                  Provider.of<IncidentsChangeNotifier>(context, listen: false)
                      .updateHomeIncidentClassifications = true;
                } else if (state is GetIncidentFailureState) {
                  setState(() {
                    _isAsync = false;
                  });
                }
              },
              child: ModalProgressHUD(
                inAsyncCall: _isAsync,
                child: Container(
                  color: Color(0xF141313),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Suspect Name",
                            style: TextStyle(
                                color: CoreStyle.operationLightTextColor
                                    .withOpacity(0.6),
                                fontFamily:
                                    CoreStyle.fontWithWeight(FontWeight.w400),
                                fontSize: 20.sp),
                          ),
                          Text(
                            name,
                            style: TextStyle(
                                color: CoreStyle.operationLightTextColor,
                                fontFamily:
                                    CoreStyle.fontWithWeight(FontWeight.w600),
                                fontSize: 25.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Color.fromARGB(255, 25, 25, 25)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    DashedCircle(
                                      dashes: 12,
                                      gapSize: 10,
                                      strokeWidth: 30,
                                      value: ((state?.currentIncident
                                                      ?.sensivitiy ??
                                                  0) *
                                              100)
                                          .ceil(),
                                      color: CoreStyle.operationRedColor,
                                      child: Container(
                                          width: 120.w,
                                          height: 120.w,
                                          child: Center(
                                              child: Text(
                                            "${((state?.currentIncident?.sensivitiy ?? 0) * 100).ceil()}",
                                            style: TextStyle(
                                                color: CoreStyle.white),
                                          ))),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                      "Area Sensitivity",
                                      style: TextStyle(
                                          color:
                                              CoreStyle.operationLightTextColor,
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w400),
                                          fontSize: 20.sp),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 48.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    DashedCircle(
                                      dashes: 12,
                                      gapSize: 10,
                                      strokeWidth: 30,
                                      value: ((state?.currentIncident
                                                      ?.percentageMap ??
                                                  0) *
                                              100)
                                          .ceil(),
                                      color: CoreStyle.operationRedColor,
                                      child: Container(
                                          width: 120.w,
                                          height: 120.w,
                                          child: Center(
                                              child: Text(
                                            "${((state?.currentIncident?.percentageMap ?? 0) * 100).ceil()}",
                                            style: TextStyle(
                                                color: CoreStyle.white),
                                          ))),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                      "Percentage Map",
                                      style: TextStyle(
                                          color:
                                              CoreStyle.operationLightTextColor,
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w400),
                                          fontSize: 20.sp),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                  ],
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
                                          color: CoreStyle
                                              .operationLightTextColor
                                              .withOpacity(0.4),
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w400),
                                          fontSize: 20.sp,
                                        )),
                                    Text(
                                      carID,
                                      style: TextStyle(
                                          color:
                                              CoreStyle.operationLightTextColor,
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w600),
                                          fontSize: 24.sp),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Text("ID Type",
                                        style: TextStyle(
                                          color: CoreStyle
                                              .operationLightTextColor
                                              .withOpacity(0.4),
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w400),
                                          fontSize: 20.sp,
                                        )),
                                    Text(
                                      idType,
                                      style: TextStyle(
                                          color:
                                              CoreStyle.operationLightTextColor,
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w600),
                                          fontSize: 24.sp),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Text("ID No",
                                        style: TextStyle(
                                          color: CoreStyle
                                              .operationLightTextColor
                                              .withOpacity(0.4),
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w400),
                                          fontSize: 20.sp,
                                        )),
                                    Text(
                                      idNo,
                                      style: TextStyle(
                                          color:
                                              CoreStyle.operationLightTextColor,
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w600),
                                          fontSize: 24.sp),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Text("Nationality",
                                        style: TextStyle(
                                          color: CoreStyle
                                              .operationLightTextColor
                                              .withOpacity(0.4),
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w400),
                                          fontSize: 20.sp,
                                        )),
                                    Text(
                                      nationality,
                                      style: TextStyle(
                                          color:
                                              CoreStyle.operationLightTextColor,
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w600),
                                          fontSize: 24.sp),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Text("Location",
                                        style: TextStyle(
                                          color: CoreStyle
                                              .operationLightTextColor
                                              .withOpacity(0.4),
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w400),
                                          fontSize: 20.sp,
                                        )),
                                    FutureBuilder(
                                      future: location,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                            width: 50.w,
                                            height: 50.w,
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        } else if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data,
                                            style: TextStyle(
                                                color: CoreStyle
                                                    .operationLightTextColor,
                                                fontFamily:
                                                    CoreStyle.fontWithWeight(
                                                        FontWeight.w600),
                                                fontSize: 24.sp),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Text("Date Raised",
                                        style: TextStyle(
                                          color: CoreStyle
                                              .operationLightTextColor
                                              .withOpacity(0.4),
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w400),
                                          fontSize: 20.sp,
                                        )),
                                    Text(
                                      state?.currentIncident?.createdAt
                                              ?.toIso8601String() ??
                                          "",
                                      style: TextStyle(
                                          color:
                                              CoreStyle.operationLightTextColor,
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w600),
                                          fontSize: 24.sp),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Suspect Level",
                                            style: TextStyle(
                                              color: CoreStyle
                                                  .operationLightTextColor
                                                  .withOpacity(0.4),
                                              fontFamily:
                                                  CoreStyle.fontWithWeight(
                                                      FontWeight.w400),
                                              fontSize: 20.sp,
                                            )),
                                        Container(
                                          width: 70.w,
                                          height: 25.h,
                                          decoration: BoxDecoration(
                                              color:
                                                  CoreStyle.operationDashColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.r))),
                                          child: Center(
                                            child: Text(
                                              "E",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily:
                                                      CoreStyle.fontWithWeight(
                                                          FontWeight.w500),
                                                  fontSize: 24.sp),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Criminal Login Result",
                                            style: TextStyle(
                                              color: CoreStyle
                                                  .operationLightTextColor
                                                  .withOpacity(0.4),
                                              fontFamily:
                                                  CoreStyle.fontWithWeight(
                                                      FontWeight.w400),
                                              fontSize: 20.sp,
                                            )),
                                        Container(
                                          width: 110.w,
                                          height: 30.h,
                                          decoration: BoxDecoration(
                                              color:
                                                  CoreStyle.operationDashColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.r))),
                                          child: Center(
                                            child: Text(
                                              suspectLevel,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily:
                                                      CoreStyle.fontWithWeight(
                                                          FontWeight.w600),
                                                  fontSize: 20.sp),
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
                          Consumer<IncidentsChangeNotifier>(
                            builder: (context, state, _) {
                              var pinned = Provider.of<IncidentsChangeNotifier>(
                                      context,
                                      listen: false)
                                  .incidents
                                  .firstWhere(
                                      (element) =>
                                          element.id ==
                                          Provider.of<IncidentsChangeNotifier>(
                                                  context)
                                              .currentIncident
                                              .id,
                                      orElse: () => null);
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    if (pinned == null) {
                                      Provider.of<IncidentsChangeNotifier>(
                                              context,
                                              listen: false)
                                          .addIncident(Provider.of<
                                                      IncidentsChangeNotifier>(
                                                  context,
                                                  listen: false)
                                              .currentIncident);
                                    } else {
                                      Provider.of<IncidentsChangeNotifier>(
                                              context,
                                              listen: false)
                                          .deleteIncident(Provider.of<
                                                      IncidentsChangeNotifier>(
                                                  context,
                                                  listen: false)
                                              .currentIncident);
                                    }
                                  });
                                },
                                child: Container(
                                  height: 50.h,
                                  width: double.maxFinite,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 24.w),
                                  decoration: BoxDecoration(
                                      color: Color(0xF272727).withOpacity(0.7),
                                      borderRadius:
                                          BorderRadius.circular(12.r)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          IMG_PIN,
                                          width: 20.w,
                                          height: 20.h,
                                        ),
                                        Text(
                                          pinned == null
                                              ? "Pin To Top"
                                              : "UnPin From Top",
                                          style: TextStyle(
                                            color: CoreStyle
                                                .operationLightTextColor,
                                            fontSize: 20.sp,
                                            fontFamily:
                                                CoreStyle.fontWithWeight(
                                                    FontWeight.w400),
                                          ),
                                        ),
                                        Container(
                                          width: 10,
                                          height: 10,
                                        )
                                      ]),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          InkWell(
                            onTap: () {
                              Provider.of<IncidentsChangeNotifier>(context,
                                      listen: false)
                                  .showSubjectData = true;
                            },
                            child: Container(
                              height: 50.h,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: Color(0xF272727).withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Center(
                                child: Text(
                                  "Suspect Data",
                                  style: TextStyle(
                                    color: CoreStyle.operationLightTextColor,
                                    fontSize: 20.sp,
                                    fontFamily: CoreStyle.fontWithWeight(
                                        FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 50.h,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: Color(0xF272727).withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Center(
                                child: Text(
                                  "Criminal Logic Report",
                                  style: TextStyle(
                                    color: CoreStyle.operationLightTextColor,
                                    fontSize: 20.sp,
                                    fontFamily: CoreStyle.fontWithWeight(
                                        FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            children: [

                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    if (state.currentIncident.classification ==
                                        "gamma") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Container(
                                        height: 40.h,
                                        child: Center(
                                          child: Text(
                                              "Can't upgrade Gamma Incident"),
                                        ),
                                      )));
                                    } else if (state
                                            .currentIncident.classification ==
                                        "delta") {
                                      _incidentsBloc.add(UpgradeIncident(
                                          UpdateIncidentParam(
                                              id: _incidentID,
                                              classification: "gamma")));
                                      setState(() {
                                        _isAsync = true;
                                      });
                                    } else if (state
                                            .currentIncident.classification ==
                                        "beta") {
                                      _incidentsBloc.add(UpgradeIncident(
                                          UpdateIncidentParam(
                                              id: _incidentID,
                                              classification: "delta")));
                                      setState(() {
                                        _isAsync = true;
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        color: CoreStyle.operationDarkGreen,
                                        borderRadius:
                                            BorderRadius.circular(12.r)),
                                    child: Center(
                                      child: Text(
                                        "Upgrade",
                                        style: TextStyle(
                                          color:
                                              CoreStyle.operationLightTextColor,
                                          fontSize: 20.sp,
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w,),
                              Expanded(
                                child: BlocListener(
                                  bloc: _incidentsBloc,
                                  listener: (context, state) {

                                    if (state is DeleteIncidentSuccessState) {

                                      setState(() {
                                        _isAsync = false;
                                      });
                                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                        Provider.of<IncidentsChangeNotifier>(context, listen: false)
                                            .updateHomeIncidentClassifications = true;
                                      });
                                    } else if (state is GetIncidentFailureState) {
                                      setState(() {
                                        _isAsync = false;
                                      });
                                    }
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isAsync = true;
                                      });

                                      _incidentsBloc.add(DeleteIncident(
                                          SingleIncidentParam(
                                              id: state.currentIncident.id)));
                                    },
                                    child: Container(
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12.r),
                                          color: CoreStyle.operationRose2Color),
                                      child: Center(
                                        child: Text(
                                          "Dismiss",
                                          style: TextStyle(
                                              color:
                                                  CoreStyle.operationLightTextColor,
                                              fontFamily: CoreStyle.fontWithWeight(
                                                  FontWeight.w600)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          )
                        ]),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
