import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/core/http/api_url.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';
import 'package:micropolis_test/features/incident/data/params/incidents_param.dart';
import 'package:micropolis_test/features/incident/data/params/single_incident_param.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_bloc.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_event.dart';
import 'package:micropolis_test/features/incident/presentation/bloc/incident_state.dart';
import 'package:micropolis_test/features/incident/presentation/notifiers/incidents_notifier.dart';
import 'package:micropolis_test/features/incident/presentation/widgets/dashed_circle.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';

class IncidentsListWidget extends StatefulWidget {
  final String type;

  const IncidentsListWidget({
    Key key,
    this.type,
  }) : super(key: key);

  @override
  _IncidentsListWidgetState createState() {
    // TODO: implement createState
    return _IncidentsListWidgetState();
  }
}

class _IncidentsListWidgetState extends State<IncidentsListWidget> {
  int _selectedItem = 0;

  var _incidentsBloc = IncidentsListBloc();

  var _currentPage = 0;
  var _stopFetchingData = false;
  var _controller = ScrollController();
  List<IncidentsDatum> _incidents = [];

  @override
  void initState() {
    _incidentsBloc.add(GetIncidents(IncidentsParam(
        lookup: "classification:${widget.type}",
        limit: 20,
        page: _currentPage)));

    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
          // You're at the top.
        } else {
          if (_stopFetchingData == false) {
            _currentPage += 1;
            _incidentsBloc.add(GetIncidents(IncidentsParam(
                lookup: "classification:${widget.type}",
                limit: 20,
                page: _currentPage)));
          }
        }
      }
    });
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
        child: StreamBuilder(
          stream: mqttHelper.incidentReceived,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              //{"title": "Incident, person is wanted", "body": {"incident_id": "1"}}
              var data = (snapshot.data as Map<String, dynamic>).values.first
                  as Map<String, dynamic>;
              var id = data["body"]["incident_id"];
              if (id != null) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Container(
                    height: 40.h,
                    child: Center(
                      child: Text("New incident\n${data["title"]}"),
                    ),
                  )));
                });
                _incidentsBloc
                    .add(GetSingleIncident(SingleIncidentParam(id: id)));
              }
            }
            return Container(
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
                    buildWhen: (prev, current) {
                      return prev != current;
                    },
                    builder: (context, state) {
                      if (state is GetSingleIncidentSuccessState) {
                        var typeToQuery = widget.type == "gamma"
                            ? BehavioralClass.GAMMA
                            : widget.type == "delta"
                                ? BehavioralClass.DELTA
                                : widget.type == "beta"
                                    ? BehavioralClass.BETA
                                    : BehavioralClass.ALPHA;

                        if (state.incident.data.classification == typeToQuery) {
                          if (_incidents.firstWhere(
                                  (element) =>
                                      element.id == state.incident.data.id,
                                  orElse: () => null) ==
                              null) {
                            _incidents.insert(0, state.incident.data);
                            print("single incident");
                          }
                        }
                        return _refreshIncidents();
                      } else if (state is GetIncidentsSuccessState) {
                        print(state.incidents.data.length);
                        if (state.incidents.data.length < 20) {
                          _stopFetchingData = true;
                        }
                        var typeToQuery = widget.type == "gamma"
                            ? BehavioralClass.GAMMA
                            : widget.type == "delta"
                                ? BehavioralClass.DELTA
                                : widget.type == "beta"
                                    ? BehavioralClass.BETA
                                    : BehavioralClass.ALPHA;
                        var incidents = state.incidents.data
                            .where((element) =>
                                element.classification == typeToQuery)
                            .toList();

                        for (var inc in incidents) {
                          if (_incidents.firstWhere(
                                  (element) => element.id == inc.id,
                                  orElse: () => null) ==
                              null) {
                            _incidents.add(inc);
                          }
                        }

                        return _refreshIncidents();
                      } else {
                        return _incidents.length > 0
                            ? _buildIncidentsContent(true)
                            : Center(
                                child: CircularProgressIndicator(),
                              );
                      }
                    },
                  )
                ],
              ),
            );
          },
        ));
  }

  _refreshIncidents() {
    if (Provider.of<IncidentsChangeNotifier>(context, listen: false)
            .currentIncident !=
        null) {
      _selectedItem = _incidents.indexWhere((element) =>
          element.id ==
          Provider.of<IncidentsChangeNotifier>(context, listen: false)
              .currentIncident
              .id);
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_incidents.length > 0 &&
          (_selectedItem < 0 ||
              Provider.of<IncidentsChangeNotifier>(context, listen: false)
                      .currentIncident ==
                  null)) {
        _loadData(0);
      }
    });
    return _buildIncidentsContent(false);
  }

  _loadData(int index) {
    setState(() {
      _selectedItem = index;
    });

    Provider.of<IncidentsChangeNotifier>(context, listen: false)
        .currentIncident = _incidents[index];
  }

  _buildIncidentsContent(bool loading) {
    return Expanded(
      child: Consumer<IncidentsChangeNotifier>(
        builder: (context, state, _) {
          if (state.updateHomeIncidentClassifications == true) {
            _selectedItem = 0;
            _currentPage = 0;
            _incidents.clear();
            _stopFetchingData = false;
            _incidentsBloc.add(GetIncidents(IncidentsParam(
                lookup: "classification:${widget.type}",
                limit: 20,
                page: _currentPage)));
          }
          return ListView.builder(
            controller: _controller,
            itemBuilder: (context, index) {
              if (index == _incidents.length) {
                return Container(
                    width: double.maxFinite,
                    height: 80.h,
                    child: Center(child: CircularProgressIndicator()));
              }
              var isPinned = Provider.of<IncidentsChangeNotifier>(context,
                              listen: false)
                          .incidents
                          .firstWhere(
                              (element) => element.id == _incidents[index].id,
                              orElse: () => null) !=
                      null
                  ? true
                  : false;

              return GestureDetector(
                onTap: () {
                  _loadData(index);
                },
                child: IncidentItemWidget(
                  suspectPercentage: min((index + 1) * 10, 100),
                  incidentName: _incidents[index].incidentDesc,
                  incidentID: _incidents[index].id,
                  incidentLetter: _incidents[index].incidentType,
                  incidentAction: _incidents[index].vehicleId,
                  isPinned: isPinned,
                  isSelected: index == _selectedItem ? true : false,
                  pinnedPressed: () {
                    if (isPinned) {
                      Provider.of<IncidentsChangeNotifier>(context,
                              listen: false)
                          .deleteIncident(_incidents[index]);
                    } else {
                      Provider.of<IncidentsChangeNotifier>(context,
                              listen: false)
                          .addIncident(_incidents[index]);
                    }
                    setState(() {});
                  },
                ),
              );
            },
            itemCount: _stopFetchingData == false
                ? _incidents.length + 1
                : _incidents.length,
            scrollDirection: Axis.vertical,
          );
        },
      ),
    );
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
  void didUpdateWidget(covariant IncidentItemWidget oldWidget) {
    _isPinned = widget.isPinned;
    super.didUpdateWidget(oldWidget);
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
