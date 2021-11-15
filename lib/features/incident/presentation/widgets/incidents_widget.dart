import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
import 'package:micropolis_test/navigation_service.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../main.dart';
import '../../../../service_locator.dart';

List<IncidentModel> incidentsList = [];
int _selectedItem = 0;

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

class _IncidentsListWidgetState extends State<IncidentsListWidget>
    with SingleTickerProviderStateMixin {
  var _incidentsBloc = IncidentsListBloc();

  var _currentPage = 0;
  var _stopFetchingData = false;
  var _controller = ScrollController();
  var fullSize = true;
  AnimationController _animationController;
  Animation _drawerAnimation;
  var _type = "";

  @override
  void initState() {
    _type = widget.type;

    if (_selectedItem >= incidentsList.length) {
      _selectedItem = 0;
    }

    _incidentsBloc.add(GetIncidents(
        IncidentsParam(sort: "published_at", populate: ["\"vehicle\""])));

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animationController.addListener(() {
      setState(() {});
    });

    _drawerAnimation = Tween<double>(begin: 1920.w - 640.w, end: 1920.w - 165.w)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeIn));

    /*_controller.addListener(() {
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
    });*/
    super.initState();
  }

  @override
  void dispose() {
    _incidentsBloc.close();
    _animationController.removeListener(() {});

    Future.delayed(Duration(milliseconds: 200)).then((value) =>
        Provider.of<IncidentsChangeNotifier>(
                locator<NavigationService>().getNavigationKey.currentContext,
                listen: false)
            .currentIncidentType = -1);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 80.h,
        right: 0,
        bottom: 0,
        left: _drawerAnimation.value,
        child: Consumer<IncidentsChangeNotifier>(
          builder: (context, state, _) {
            if (state.currentIncidentType == 0 && _type != "beta") {
              _type = "beta";
              incidentsList.clear();
              _incidentsBloc.add(GetIncidents(IncidentsParam(
                  sort: "published_at", populate: ["\"vehicle\""])));
            } else if (state.currentIncidentType == 1 && _type != "delta") {
              _type = "delta";
              incidentsList.clear();
              _incidentsBloc.add(GetIncidents(IncidentsParam(
                  sort: "published_at", populate: ["\"vehicle\""])));
            } else if (state.currentIncidentType == 2 && _type != "gamma") {
              _type = "gamma";
              incidentsList.clear();
              _incidentsBloc.add(GetIncidents(IncidentsParam(
                  sort: "published_at", populate: ["\"vehicle\""])));
            }

            return StreamBuilder(
              stream: mqttHelper.incidentReceived,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  //{"title": "Incident, person is wanted", "body": {"incident_id": "1"}}
                  var data = (snapshot.data as Map<String, dynamic>)
                      .values
                      .first as Map<String, dynamic>;
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
                  padding: EdgeInsets.only(left: 40.w),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 30,
                        spreadRadius: 2)
                  ]),
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
                            mainAxisAlignment: fullSize == true
                                ? MainAxisAlignment.spaceBetween
                                : MainAxisAlignment.center,
                            children: [
                              if (fullSize &&
                                  _animationController.isAnimating == false)
                                Image.asset(
                                  _type == "gamma"
                                      ? IMG_GAMMA
                                      : _type == "delta"
                                          ? IMG_DELTA
                                          : _type == "beta"
                                              ? IMG_BETA
                                              : IMG_PERSON,
                                  width: 50.w,
                                  height: 50.h,
                                ),
                              if (fullSize &&
                                  _animationController.isAnimating == false)
                                Container(
                                  height: 50.h,
                                  child: Text(
                                    _type == "gamma"
                                        ? "Gamma Cases"
                                        : _type == "delta"
                                            ? "Delta Cases"
                                            : _type == "beta"
                                                ? "Beta Cases"
                                                : "Something",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              GestureDetector(
                                onTap: () {
                                  fullSize = !fullSize;
                                  if (fullSize == true) {
                                    _animationController.reverse();
                                  } else {
                                    _animationController.forward();
                                  }
                                },
                                child: Container(
                                  height: 50.h,
                                  color: Colors.transparent,
                                  child: Icon(
                                    fullSize == true ? Icons.sort : Icons.menu,
                                    size: 40.w,
                                    color: CoreStyle.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        BlocBuilder<IncidentsListBloc, IncidentsState>(
                          bloc: _incidentsBloc,
                          builder: (context, state) {
                            print(state);
                            if (state is GetSingleIncidentSuccessState) {
                              var typeToQuery = _type;

                              if (state.incident.classification ==
                                  typeToQuery) {
                                if (incidentsList.firstWhere(
                                        (element) =>
                                            element.id == state.incident.id,
                                        orElse: () => null) ==
                                    null) {
                                  incidentsList.insert(0, state.incident);
                                }
                              }
                              return _refreshIncidents();
                            } else if (state is GetIncidentsSuccessState) {
                              print(state.incidents.data.length);
                              if (state.incidents.data.length < 20) {
                                _stopFetchingData = true;
                              }
                              var typeToQuery = _type;

                              var pinned = Provider.of<IncidentsChangeNotifier>(
                                      context,
                                      listen: false)
                                  .incidents;

                              for (var inc in pinned) {
                                if (incidentsList.firstWhere(
                                        (element) => element.id == inc.id,
                                        orElse: () => null) ==
                                    null) {
                                  incidentsList.add(inc);
                                }
                              }

                              var incidents = state.incidents.data
                                  .where((element) =>
                                      element.classification == typeToQuery)
                                  .toList();

                              for (var inc in incidents) {
                                if (incidentsList.firstWhere(
                                        (element) => element.id == inc.id,
                                        orElse: () => null) ==
                                    null) {
                                  incidentsList.add(inc);
                                }
                              }

                              return _refreshIncidents();
                            } else {
                              return incidentsList.length > 0
                                  ? fullSize == true &&
                                          _animationController.isAnimating ==
                                              false
                                      ? _buildIncidentsContent(true)
                                      : _buildIncidentsContentSmall(true)
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }

  _refreshIncidents() {
    if (Provider.of<IncidentsChangeNotifier>(context, listen: false)
            .currentIncident !=
        null) {
      _selectedItem = incidentsList.indexWhere((element) =>
          element.id ==
          Provider.of<IncidentsChangeNotifier>(context, listen: false)
              .currentIncident
              .id);
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (incidentsList.length > 0 &&
          (_selectedItem < 0 ||
              Provider.of<IncidentsChangeNotifier>(context, listen: false)
                      .currentIncident ==
                  null)) {
        _loadData(0);
      }
    });

    return fullSize == true && _animationController.isAnimating == false
        ? _buildIncidentsContent(false)
        : _buildIncidentsContentSmall(false);
  }

  _loadData(int index) {
    setState(() {
      _selectedItem = index;
    });

    Provider.of<IncidentsChangeNotifier>(context, listen: false)
        .currentIncident = incidentsList[index];
  }

  _buildIncidentsContentSmall(bool loading) {
    return Expanded(
      child: Consumer<IncidentsChangeNotifier>(
        builder: (context, state, _) {
          if (state.updateHomeIncidentClassifications == true) {
            _selectedItem = 0;
            _currentPage = 0;
            incidentsList.clear();
            _stopFetchingData = false;
            _incidentsBloc.add(GetIncidents(IncidentsParam(
                sort: "published_at", populate: ["\"vehicle\""])));
          }
          return ListView.builder(
            controller: _controller,
            itemBuilder: (context, index) {
              if (index == incidentsList.length) {
                return Container(
                    width: double.maxFinite,
                    height: 80.h,
                    child: Center(child: CircularProgressIndicator()));
              }
              var isPinned =
                  Provider.of<IncidentsChangeNotifier>(context, listen: false)
                              .incidents
                              .firstWhere(
                                  (element) =>
                                      element.id == incidentsList[index].id,
                                  orElse: () => null) !=
                          null
                      ? true
                      : false;

              return GestureDetector(
                onTap: () {
                  _loadData(index);
                },
                child: IncidentItemWidget(
                  suspectPercentage: incidentsList[index].percentageMap,
                  incidentName: incidentsList[index].id,
                  incidentID: incidentsList[index].id,
                  incidentLetter: incidentsList[index].classification,
                  incidentAction:
                      incidentsList[index].behaviorAnalysisClassification,
                  location: LatLng(
                      double.tryParse(incidentsList[index].latitude),
                      double.tryParse(incidentsList[index].longitude)),
                  isPinned: isPinned,
                  small: true,
                  isSelected: index == _selectedItem ? true : false,
                  pinnedPressed: () {
                    if (isPinned) {
                      Provider.of<IncidentsChangeNotifier>(context,
                              listen: false)
                          .deleteIncident(incidentsList[index]);
                    } else {
                      Provider.of<IncidentsChangeNotifier>(context,
                              listen: false)
                          .addIncident(incidentsList[index]);
                    }
                    setState(() {});
                  },
                ),
              );
            },
            itemCount: _stopFetchingData == false
                ? incidentsList.length + 1
                : incidentsList.length,
            scrollDirection: Axis.vertical,
          );
        },
      ),
    );
  }

  _buildIncidentsContent(bool loading) {
    return Expanded(
      child: Consumer<IncidentsChangeNotifier>(
        builder: (context, state, _) {
          if (state.updateHomeIncidentClassifications == true) {
            _selectedItem = 0;
            _currentPage = 0;
            incidentsList.clear();
            _stopFetchingData = false;
            _incidentsBloc.add(GetIncidents(IncidentsParam(
                sort: "published_at", populate: ["\"vehicle\""])));
          }
          return ListView.builder(
            controller: _controller,
            itemBuilder: (context, index) {
              if (index == incidentsList.length) {
                return Container(
                    width: double.maxFinite,
                    height: 80.h,
                    child: Center(child: CircularProgressIndicator()));
              }
              var isPinned =
                  Provider.of<IncidentsChangeNotifier>(context, listen: false)
                              .incidents
                              .firstWhere(
                                  (element) =>
                                      element.id == incidentsList[index].id,
                                  orElse: () => null) !=
                          null
                      ? true
                      : false;

              return GestureDetector(
                onTap: () {
                  _loadData(index);
                },
                child: IncidentItemWidget(
                  suspectPercentage: incidentsList[index].percentageMap,
                  incidentName: incidentsList[index].id,
                  incidentID: incidentsList[index].id,
                  incidentLetter: incidentsList[index].classification,
                  incidentAction:
                      incidentsList[index].behaviorAnalysisClassification,
                  location: LatLng(
                      double.tryParse(incidentsList[index].latitude),
                      double.tryParse(incidentsList[index].longitude)),
                  isPinned: isPinned,
                  isSelected: index == _selectedItem ? true : false,
                  pinnedPressed: () {
                    if (isPinned) {
                      Provider.of<IncidentsChangeNotifier>(context,
                              listen: false)
                          .deleteIncident(incidentsList[index]);
                    } else {
                      Provider.of<IncidentsChangeNotifier>(context,
                              listen: false)
                          .addIncident(incidentsList[index]);
                    }
                    setState(() {});
                  },
                ),
              );
            },
            itemCount: _stopFetchingData == false
                ? incidentsList.length + 1
                : incidentsList.length,
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
  final bool small;
  final LatLng location;
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
      this.small,
      this.location,
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
  String _locality;
  String _name;

  @override
  void initState() {
    _isPinned = widget.isPinned;
    _getLocation();
    super.initState();
  }

  _getLocation() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(52.2165157, 6.9437819);
    if (placemarks != null && placemarks.isNotEmpty) {
      setState(() {
        _locality = placemarks?.first?.locality;
        _name = placemarks?.first?.name;
      });
    }
  }

  @override
  void didUpdateWidget(covariant IncidentItemWidget oldWidget) {
    _isPinned = widget.isPinned;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.small == null || widget.small == false) {
      return Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              height: 90.h,
              decoration: BoxDecoration(
                color: widget.isSelected == true
                    ? Color(0xFF212121)
                    : Color(0xFF212121).withOpacity(0.4),
                borderRadius: BorderRadius.all(Radius.circular(30.r)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 70.w,
                      height: 70.w,
                      decoration: BoxDecoration(
                          color: widget.isSelected == false
                              ? CoreStyle.white.withOpacity(0.06)
                              : CoreStyle.operationGreenContent,
                          borderRadius:
                              BorderRadius.all(Radius.circular(35.w))),
                      child: Icon(
                        Icons.pin_drop,
                        color: Colors.white,
                        size: 35.w,
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_locality != null)
                        Text(
                          _locality,
                          style: TextStyle(
                              color: Color(0xFFEAEAEA),
                              fontFamily: CoreStyle.fontWithWeight(
                                FontWeight.w500,
                              ),
                              fontSize: 26.sp),
                        ),
                      if (_name != null)
                        Text(_name,
                            style: TextStyle(
                                color: Color(0xFFEAEAEA).withOpacity(0.6),
                                fontFamily: CoreStyle.fontWithWeight(
                                  FontWeight.w400,
                                ),
                                fontSize: 22.sp))
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      widget.pinnedPressed();
                    },
                    child: Container(
                        width: 54.w,
                        height: 54.w,
                        padding: EdgeInsets.all(15.w),
                        decoration: BoxDecoration(
                            color: _isPinned == false
                                ? CoreStyle.operationPinBlackColor
                                : CoreStyle.operationGreenContent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r))),
                        child: Image.asset(
                          IMG_PIN,
                          color: Color(0xFF898989),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            child: Container(
              height: 90.h,
              decoration: BoxDecoration(
                color: CoreStyle.operationIncidentItemListBlackColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    bottomLeft: Radius.circular(30.r)),
              ),
              child: Center(
                child: Container(
                    width: 70.w,
                    height: 70.w,
                    decoration: BoxDecoration(
                        color: widget.isSelected == false
                            ? CoreStyle.white.withOpacity(0.06)
                            : CoreStyle.operationGreenContent,
                        borderRadius: BorderRadius.all(Radius.circular(35.w))),
                    child: Icon(
                      Icons.pin_drop,
                      color: Colors.white,
                      size: 35.w,
                    )),
              ),
            ),
          ),
        ],
      );
    }
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
