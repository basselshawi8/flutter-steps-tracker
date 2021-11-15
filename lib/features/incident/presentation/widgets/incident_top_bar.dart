import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_bloc.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_state.dart';
import 'package:micropolis_test/features/incident/presentation/notifiers/incidents_notifier.dart';
import 'package:provider/provider.dart';

class IncidentsTopBar extends StatefulWidget {
  final String type;

  const IncidentsTopBar({Key key, this.type}) : super(key: key);

  @override
  _IncidentsTopBarState createState() {
    return _IncidentsTopBarState();
  }
}

class _IncidentsTopBarState extends State<IncidentsTopBar> {
  var _selectedIndex = 0;

  @override
  void initState() {
    if (widget.type == "beta") {
      _selectedIndex = 0;
    } else if (widget.type == "delta") {
      _selectedIndex = 1;
    } else {
      _selectedIndex = 2;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Container(
          decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 30,
                spreadRadius: 4),
          ]),
          child: Container(
            width: double.maxFinite,
            height: 80.h,
            color: Color(0xFF141313),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 0;
                            Provider.of<IncidentsChangeNotifier>(context,
                                    listen: false)
                                .currentIncidentType = _selectedIndex;
                          });
                        },
                        child: Container(
                          width: 225.w,
                          height: 85.h,
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      IMG_BETA,
                                      color: _selectedIndex == 0
                                          ? CoreStyle.white
                                          : Color.fromARGB(255, 83, 83, 83),
                                      width: 50.w,
                                    ),
                                    SizedBox(width: 24.w),
                                    Text(
                                      "Beta",
                                      style: TextStyle(
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w400),
                                          fontSize: 30.sp,
                                          color: _selectedIndex == 0
                                              ? CoreStyle.white
                                              : CoreStyle.white
                                                  .withOpacity(0.4)),
                                    ),
                                    SizedBox(width: 24.w),
                                    BlocBuilder<IncidentsListBloc,
                                        IncidentsState>(
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
                                          return Text(
                                            "${classifications.length == 0 ? 0 : classifications?.first?.count ?? 0}",
                                            style: TextStyle(
                                                color: _selectedIndex == 0
                                                    ? CoreStyle.white
                                                    : CoreStyle.white
                                                        .withOpacity(0.4),
                                                fontSize: 40.sp),
                                          );
                                        } else {
                                          return Container(
                                            width: 20.w,
                                            height: 20.w,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                              if (_selectedIndex == 0)
                                Positioned(
                                    bottom: -13.h,
                                    left: 0.w,
                                    right: 0.w,
                                    child: Container(
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFBD5CF0),
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                    ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 1;
                            Provider.of<IncidentsChangeNotifier>(context,
                                    listen: false)
                                .currentIncidentType = _selectedIndex;
                          });
                        },
                        child: Container(
                          width: 225.w,
                          height: 85.h,
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      IMG_DELTA,
                                      color: _selectedIndex == 1
                                          ? CoreStyle.white
                                          : Color.fromARGB(255, 83, 83, 83),
                                      width: 50.w,
                                    ),
                                    SizedBox(width: 24.w),
                                    Text(
                                      "Delta",
                                      style: TextStyle(
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w400),
                                          fontSize: 30.sp,
                                          color: _selectedIndex == 1
                                              ? CoreStyle.white
                                              : CoreStyle.white
                                                  .withOpacity(0.4)),
                                    ),
                                    SizedBox(
                                      width: 24.w,
                                    ),
                                    BlocBuilder<IncidentsListBloc,
                                        IncidentsState>(
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
                                                      .contains("delta") ==
                                                  true);

                                          return Text(
                                            "${classifications.length == 0 ? 0 : classifications?.first?.count ?? 0}",
                                            style: TextStyle(
                                                color: _selectedIndex == 1
                                                    ? CoreStyle.white
                                                    : CoreStyle.white
                                                        .withOpacity(0.4),
                                                fontSize: 40.sp),
                                          );
                                        } else {
                                          return Container(
                                            width: 20.w,
                                            height: 20.w,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                              if (_selectedIndex == 1)
                                Positioned(
                                    bottom: -13.h,
                                    left: 0.w,
                                    right: 0.w,
                                    child: Container(
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF0AC5C),
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                    ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 2;
                            Provider.of<IncidentsChangeNotifier>(context,
                                    listen: false)
                                .currentIncidentType = _selectedIndex;
                          });
                        },
                        child: Container(
                          width: 250.w,
                          height: 85.h,
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      IMG_GAMMA,
                                      width: 50.w,
                                      color: _selectedIndex == 2
                                          ? CoreStyle.white
                                          : Color.fromARGB(255, 83, 83, 83),
                                    ),
                                    SizedBox(
                                      width: 24.w,
                                    ),
                                    Text(
                                      "Gamma",
                                      style: TextStyle(
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w400),
                                          fontSize: 30.sp,
                                          color: _selectedIndex == 2
                                              ? CoreStyle.white
                                              : CoreStyle.white
                                                  .withOpacity(0.4)),
                                    ),
                                    SizedBox(
                                      width: 24.w,
                                    ),
                                    BlocBuilder<IncidentsListBloc,
                                        IncidentsState>(
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
                                                      .contains("gamma") ==
                                                  true);
                                          return Text(
                                            "${classifications.length == 0 ? 0 : classifications?.first?.count ?? 0}",
                                            style: TextStyle(
                                                color: _selectedIndex == 2
                                                    ? CoreStyle.white
                                                    : CoreStyle.white
                                                        .withOpacity(0.4),
                                                fontSize: 40.sp),
                                          );
                                        } else {
                                          return Container(
                                            width: 20.w,
                                            height: 20.w,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                              if (_selectedIndex == 2)
                                Positioned(
                                    bottom: -13.h,
                                    left: 0.w,
                                    right: 0.w,
                                    child: Container(
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF05C5C),
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                    ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 30.h,
                    right: 12.w,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.h),
                            color: CoreStyle.white.withOpacity(0.06)),
                        child: Icon(
                          Icons.close,
                          size: 35.w,
                          color: CoreStyle.white.withOpacity(0.5),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
