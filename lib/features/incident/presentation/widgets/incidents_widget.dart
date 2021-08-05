import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';
import 'package:micropolis_test/features/incident/data/params/incidents_param.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_bloc.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_event.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_state.dart';
import 'package:micropolis_test/features/incident/presentation/notifiers/incidents_notifier.dart';
import 'package:micropolis_test/features/incident/presentation/widgets/dashed_circle.dart';
import 'package:provider/provider.dart';

class IncidentsListWidget extends StatefulWidget {
  final String type;

  const IncidentsListWidget({Key key, this.type}) : super(key: key);

  @override
  _IncidentsListWidgetState createState() {
    // TODO: implement createState
    return _IncidentsListWidgetState();
  }
}

class _IncidentsListWidgetState extends State<IncidentsListWidget> {
  int _selectedItem = 0;

  var selectedFirst = false;
  var _incidentsBloc = IncidentsListBloc();

  @override
  void initState() {
    _incidentsBloc.add(GetIncidents(IncidentsParam()));
    super.initState();
  }

  @override
  void dispose() {
    _incidentsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        right: 0,
        bottom: 0,
        left: 1920.w - 400.w,
        child: Container(
          color: CoreStyle.operationIncidentListBlackColor,
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      widget.type == "gamma"
                          ? IMG_GAMMA
                          : widget.type == "delta"
                              ? IMG_DELTA
                              : widget.type == "beta"
                                  ? IMG_BETA
                                  : IMG_PERSON,
                      width: 35.w,
                      height: 35.h,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      widget.type == "gamma"
                          ? "Gamma Cases"
                          : widget.type == "delta"
                              ? "Delta Cases"
                              : widget.type == "beta"
                                  ? "Beta Cases"
                                  : "Something",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              BlocBuilder<IncidentsListBloc, IncidentsState>(
                bloc: _incidentsBloc,
                builder: (context, state) {
                  if (state is GetIncidentsSuccessState) {
                    var typeToQuery = widget.type == "gamma"
                        ? BehavioralClass.GAMMA
                        : widget.type == "delta"
                            ? BehavioralClass.DELTA
                            : widget.type == "beta"
                                ? BehavioralClass.BETA
                                : BehavioralClass.ALPHA;
                    var incidents = state.incidents.data
                        .where(
                            (element) => element.classification == typeToQuery)
                        .toList();

                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      if (incidents.length > 0 && selectedFirst == false) {
                        selectedFirst = true;
                        Provider.of<IncidentsChangeNotifier>(context,
                                listen: false)
                            .imageCap = incidents[0].imageCap;
                        Provider.of<IncidentsChangeNotifier>(context,
                                listen: false)
                            .imageMatch = incidents[0].imageMatch;

                        Provider.of<IncidentsChangeNotifier>(context,
                                listen: false)
                            .currentIncident = incidents[0];
                      }
                    });
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedItem = index;
                              });

                              Provider.of<IncidentsChangeNotifier>(context,
                                      listen: false)
                                  .imageCap = incidents[index].imageCap;
                              Provider.of<IncidentsChangeNotifier>(context,
                                      listen: false)
                                  .imageMatch = incidents[index].imageMatch;

                              Provider.of<IncidentsChangeNotifier>(context,
                                      listen: false)
                                  .currentIncident = incidents[index];
                            },
                            child: IncidentItemWidget(
                              suspectPercentage: min((index + 1) * 10, 100),
                              incidentName: incidents[index].incidentDesc,
                              incidentID: incidents[index].id,
                              incidentLetter: incidents[index].incidentType,
                              incidentAction: incidents[index].vehicleId,
                              isPinned: Provider.of<IncidentsChangeNotifier>(
                                              context,
                                              listen: false)
                                          .incidents
                                          .firstWhere(
                                              (element) =>
                                                  element.id ==
                                                  incidents[index].id,
                                              orElse: () => null) !=
                                      null
                                  ? true
                                  : false,
                              isSelected: index == _selectedItem ? true : false,
                              pinnedPressed: () {
                                Provider.of<IncidentsChangeNotifier>(context,
                                        listen: false)
                                    .addIncident(incidents[index]);
                              },
                            ),
                          );
                        },
                        itemCount: incidents.length,
                        scrollDirection: Axis.vertical,
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ));
  }
}

class IncidentItemWidget extends StatefulWidget {
  final int suspectPercentage;
  final String incidentName;
  final String incidentID;
  final String incidentLetter;
  final String incidentAction;
  final bool isPinned;
  final bool isSelected;
  final Function pinnedPressed;

  const IncidentItemWidget(
      {Key key,
      this.suspectPercentage,
      this.incidentName,
      this.incidentID,
      this.incidentLetter,
      this.isPinned,
      this.isSelected,
      this.pinnedPressed,
      this.incidentAction})
      : super(key: key);

  @override
  _IncidentItemWidgetState createState() {
    // TODO: implement createState
    return _IncidentItemWidgetState();
  }
}

class _IncidentItemWidgetState extends State<IncidentItemWidget> {
  bool _isPinned = false;

  @override
  void initState() {
    _isPinned = widget.isPinned;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.isSelected)
          Container(
            width: 19.w,
            height: 17.h,
            child: CustomPaint(
                painter: TrianglePainter(
                    strokeColor: CoreStyle.operationGreenContent,
                    strokeWidth: 30,
                    paintingStyle: PaintingStyle.fill)),
          ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                left: widget.isSelected == false ? 16.w : 0.w, right: 16.w),
            child: Container(
              height: 120.h,
              margin: EdgeInsets.symmetric(
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: CoreStyle.operationIncidentItemListBlackColor,
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
              ),
              child: Row(
                children: [
                  if (widget.isSelected)
                    Container(
                        height: double.maxFinite,
                        width: 10.w,
                        decoration: BoxDecoration(
                          color: CoreStyle.operationGreenContent,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r),
                              bottomLeft: Radius.circular(12.r)),
                        )),
                  SizedBox(
                    width: 10.w,
                  ),
                  DashedCircle(
                    dashes: 12,
                    gapSize: 10,
                    strokeWidth: 20,
                    value: widget.suspectPercentage,
                    color: CoreStyle.operationRedColor,
                    child: Container(
                        width: 80.w,
                        height: 80.w,
                        child: Center(
                            child: Text(
                          "${widget.suspectPercentage}",
                          style: TextStyle(color: CoreStyle.white),
                        ))),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        widget.incidentName,
                        style: TextStyle(
                            color: CoreStyle.operationLightTextColor
                                .withOpacity(0.6),
                            fontWeight: FontWeight.w200,
                            fontSize: 15.sp),
                      ),
                      Text(
                        "ID: ${widget.incidentID}",
                        style: TextStyle(
                            color: CoreStyle.operationLightTextColor
                                .withOpacity(0.6),
                            fontWeight: FontWeight.w200,
                            fontSize: 12.sp),
                      ),
                      Expanded(
                          child: SizedBox(
                        height: 10,
                      )),
                      Row(
                        children: [
                          Container(
                            width: 40.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                                color: CoreStyle.operationDashColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.r))),
                            child: Center(
                              child: Text(
                                widget.incidentLetter,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Container(
                            width: 80.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                                color: CoreStyle.operationDashColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.r))),
                            child: Center(
                              child: Text(
                                widget.incidentAction,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 35.w,
                          ),
                          InkWell(
                            onTap: () {
                              widget.pinnedPressed();
                              setState(() {
                                _isPinned = !_isPinned;
                              });
                            },
                            child: Container(
                                width: 30.w,
                                height: 30.w,
                                padding: EdgeInsets.all(7.w),
                                decoration: BoxDecoration(
                                    color: _isPinned == false
                                        ? CoreStyle.operationPinBlackColor
                                        : CoreStyle.operationGreenContent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.r))),
                                child: Image.asset(IMG_PIN)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6.h,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(x, 0)
      ..lineTo(x / 2, y / 2)
      ..lineTo(x, y)
      ..lineTo(x, 0);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
