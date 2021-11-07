import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/core/extensions/latLng_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/core/ui/error_widget.dart';
import 'package:micropolis_test/features/map/data/models/authority_area_model.dart';
import 'package:micropolis_test/features/map/data/models/police_department_model.dart';
import 'package:micropolis_test/features/map/data/models/region_model.dart';
import 'package:micropolis_test/features/map/data/models/region_type_model.dart';
import 'package:micropolis_test/features/map/presentation/bloc/bloc.dart';
import 'package:micropolis_test/features/map/presentation/ui_extension/edit_polygon_extension.dart';
import 'package:micropolis_test/features/map/presentation/ui_extension/edit_authority_details.dart';
import 'package:micropolis_test/features/user_managment/presentation/change_notifiers/user_managment_change_notifier.dart';
import 'package:provider/provider.dart';

class CriticalTime {
  final TimeOfDay from;
  final TimeOfDay to;
  final String day;
  final bool flagSuspect;

  CriticalTime(this.from, this.to, this.day, this.flagSuspect);
}

class ColoredPolygon {
  final List<LatLng> points;
  final Color color;

  ColoredPolygon(this.points, this.color);
}

class PolygonDrawer extends StatefulWidget {
  static const routeName = '/mapDrawer';

  @override
  PolygonDrawerState createState() {
    return PolygonDrawerState();
  }
}

class PolygonDrawerState extends State<PolygonDrawer> {
  GoogleMapController _controller;
  final Map<String, Marker> _markers = {};

  final Map<String, Polygon> _polygons = {};
  final List<Circle> _circles = [];
  List<Polyline> currentPolyline = [];
  List<LatLng> currentPositions = [];

  var isDrawingAuthorityMode = false;
  var isDrawingAreaMode = false;

  String policeDepartment;
  RegionData selectedRegion;
  RegionTypeData selectedRegionType;
  AuthorityAreaData selectedAuthorityArea;

  String severityValue = "1";
  List<PoliceDepartmentData> policeDepartments = [];
  List<RegionData> regions = [];
  List<RegionTypeData> regionTypes = [];
  List<AuthorityAreaData> authorityAreas = [];

  var showEditAreaDetails = false;
  var showEditAuthorityDetails = false;
  var locations = [LatLng(51.5074, 0.1278), LatLng(48.8566, 2.3522)];
  var polygonNameFocusNode = FocusNode();
  var polygonNameKey = GlobalKey<FormFieldState>();
  var polygonNameController = TextEditingController();
  List<Country> selectedCountries = [];
  List<CriticalTime> selectedDays = [];
  String selectedDay = "Mon";
  TimeOfDay from;
  TimeOfDay to;
  bool isAsync = false;
  bool flagSuspect = false;
  CancelToken cancelToken = CancelToken();

  Map<String, ColoredPolygon> polygonLocations = {
    "1": ColoredPolygon([], Colors.yellow)
  };

  Map<String, ColoredPolygon> networkPolygonLocations = {};

  @override
  void dispose() {
    cancelToken.cancel();
    super.dispose();
  }

  @override
  void initState() {
    networkPolygonLocations.clear();
    BlocProvider.of<MapBloc>(context)
        .add(GetAuthorityAreas(NoParams(cancelToken: cancelToken)));

    BlocProvider.of<MapBloc>(context)
        .add(GetSensitiveLocations(NoParams(cancelToken: cancelToken)));

    BlocProvider.of<MapBloc>(context)
        .add(GetPoliceDepartments(NoParams(cancelToken: cancelToken)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 50.h,
          width: double.maxFinite,
          color: CoreStyle.white,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "AI Configurations",
                style: TextStyle(
                    color: CoreStyle.operationBlackTextColor,
                    fontFamily: CoreStyle.fontWithWeight(FontWeight.w600),
                    fontSize: 21.sp),
              ),
              Row(
                children: [
                  InkWell(
                    child: Container(
                      height: 35.h,
                      width: 140.w,
                      decoration: BoxDecoration(
                          color: Provider.of<UserManagementChangeNotifier>(
                                          context,
                                          listen: false)
                                      .showAddArea ==
                                  false
                              ? CoreStyle.operationButtonGreenColor
                              : Colors.black.withOpacity(0.075),
                          borderRadius: BorderRadius.circular(7.r)),
                      child: Center(
                        child: Text(
                          Provider.of<UserManagementChangeNotifier>(context,
                                          listen: false)
                                      .showAddArea ==
                                  false
                              ? "+   New Area"
                              : "Cancel",
                          style: TextStyle(
                              color: Provider.of<UserManagementChangeNotifier>(
                                              context,
                                              listen: false)
                                          .showAddArea ==
                                      false
                                  ? CoreStyle.white
                                  : CoreStyle.operationGrayTextColor,
                              fontSize: 15.sp,
                              fontFamily:
                                  CoreStyle.fontWithWeight(FontWeight.w300)),
                        ),
                      ),
                    ),
                    onTap: () {
                      Provider.of<UserManagementChangeNotifier>(context,
                                  listen: false)
                              .showAddArea =
                          !Provider.of<UserManagementChangeNotifier>(context,
                                  listen: false)
                              .showAddArea;
                      isDrawingAreaMode =
                          Provider.of<UserManagementChangeNotifier>(context,
                                  listen: false)
                              .showAddArea;
                    },
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  InkWell(
                    child: Container(
                      height: 35.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                          color: Provider.of<UserManagementChangeNotifier>(
                                          context,
                                          listen: false)
                                      .showAddAuthorityArea ==
                                  false
                              ? CoreStyle.operationButtonGreenColor
                              : Colors.black.withOpacity(0.075),
                          borderRadius: BorderRadius.circular(7.r)),
                      child: Center(
                        child: Text(
                          Provider.of<UserManagementChangeNotifier>(context,
                                          listen: false)
                                      .showAddAuthorityArea ==
                                  false
                              ? "+   New Authority Area"
                              : "Cancel",
                          style: TextStyle(
                              color: Provider.of<UserManagementChangeNotifier>(
                                              context,
                                              listen: false)
                                          .showAddAuthorityArea ==
                                      false
                                  ? CoreStyle.white
                                  : CoreStyle.operationGrayTextColor,
                              fontSize: 15.sp,
                              fontFamily:
                                  CoreStyle.fontWithWeight(FontWeight.w300)),
                        ),
                      ),
                    ),
                    onTap: () {
                      Provider.of<UserManagementChangeNotifier>(context,
                                  listen: false)
                              .showAddAuthorityArea =
                          !Provider.of<UserManagementChangeNotifier>(context,
                                  listen: false)
                              .showAddAuthorityArea;
                      isDrawingAuthorityMode =
                          Provider.of<UserManagementChangeNotifier>(context,
                                  listen: false)
                              .showAddAuthorityArea;
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<MapBloc, MapState>(
            buildWhen: (prev, next) {
              if (next is GetAuthorityAreasWaitingState ||
                  next is GetAuthorityAreasSuccessState ||
                  next is GetAuthorityAreasFailureState ||
                  next is GetSensitiveLocationsSuccessState) {
                return true;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              if (state is GetAuthorityAreasWaitingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetAuthorityAreasFailureState) {
                return ErrorScreenWidget(
                  error: state.error,
                  state: state,
                );
              } else if (state is GetAuthorityAreasSuccessState) {
                authorityAreas = state.authorityAreaModel.data;
                if (selectedAuthorityArea == null)
                  selectedAuthorityArea = authorityAreas.first;
                return _buildContent(
                    state.authorityAreaModel.data
                        .map((e) => e.polygon)
                        .toList(),
                    state.authorityAreaModel.data.map((t) => t.id).toList(),
                    CoreStyle.operationMapPolygonColor);
              } else if (state is GetSensitiveLocationsSuccessState) {
                return _buildContent(
                    state.sensitiveLocationModel.data
                        .map((e) => e.polygon)
                        .toList(),
                    state.sensitiveLocationModel.data.map((t) => t.id).toList(),
                    Colors.yellow);
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    ));
  }

  _buildContent(
      List<PolygonData> polygons, List<String> ids, Color polygonColor) {
    var index = 0;
    for (var poly in polygons) {
      networkPolygonLocations[ids[index]] = ColoredPolygon(
          poly.coordinates.first.map((e) => LatLng(e[0], e[1])).toList(),
          polygonColor);
      index += 1;
    }

    _buildPolygon();

    return Stack(
      children: [
        Positioned.fill(
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: const LatLng(25.2048, 55.2708),
              zoom: 12,
            ),
            polylines: currentPolyline.toSet(),
            polygons: _polygons.values.toSet(),
            circles: _circles.toSet(),
            markers: _markers.values.toSet(),
          ),
        ),
        Positioned.fill(child: GestureDetector(onTapUp: (details) async {
          if (isDrawingAreaMode == false && isDrawingAuthorityMode == false) {
            return;
          }
          var latLong = await _controller.getLatLng(ScreenCoordinate(
              x: details.localPosition.dx.toInt(),
              y: details.localPosition.dy.toInt()));

          if (currentPositions.length > 0) {
            var lastPosition = currentPositions.first;
            var dist = lastPosition.dist(latLong);
            print(dist);
            if (dist < 0.1) {
              var key = polygonLocations?.keys?.last ?? "1";
              polygonLocations["${int.tryParse(key) + 1}"] =
                  ColoredPolygon(currentPositions, polygonColor);
              currentPositions = [];
              if (isDrawingAreaMode == true) {
                isDrawingAreaMode = false;
                showEditAuthorityDetails = true;
              } else {
                isDrawingAuthorityMode = false;
                showEditAuthorityDetails = true;
              }
            } else {
              currentPositions.add(latLong);
            }
          } else {
            currentPositions.add(latLong);
          }

          _buildPolygon();
          _buildPolyline();
          _buildCircles();
          Future.delayed(Duration(milliseconds: 100))
              .then((value) => setState(() {}));
        })),
        if (Provider.of<UserManagementChangeNotifier>(context)
                .showAddAuthorityArea ==
            true) ...[
          _buildClearPolygonDrawing(),
          _buildClosePolygonDrawing(polygonColor),
          _buildRemoveLastPoint()
        ],
        if (showEditAuthorityDetails == true) editAuthorityDetails(),
        if (Provider.of<UserManagementChangeNotifier>(context).showAddArea ==
            true) ...[
          _buildClearPolygonDrawing(),
          _buildClosePolygonDrawing(polygonColor),
          _buildRemoveLastPoint()
        ],
        if (showEditAreaDetails == true) editPolygonDetails()
      ],
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
  }

  _buildMarkers() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, IMG_ROBOT_MARKER);

    _markers.clear();
    var count = 1;
    for (final position in locations) {
      final marker = Marker(
        markerId: MarkerId("robot $count"),
        position: position,
        infoWindow: InfoWindow(
          title: "robot $count",
          snippet: "robot $count position",
        ),
      );
      count += 1;
      _markers["robot $count"] = marker;
    }
  }

  _buildPolygon() async {
    _polygons.clear();
    var count = 1;
    for (var key in polygonLocations.keys) {
      final polygon = Polygon(
          polygonId: PolygonId("robot $count"),
          points: polygonLocations[key].points,
          strokeColor: polygonLocations[key].color,
          strokeWidth: 2,
          fillColor: polygonLocations[key].color.withOpacity(0.35),
          zIndex: 9,
          onTap: () {});
      count += 1;
      _polygons["robot $count"] = polygon;
    }

    for (var key in networkPolygonLocations.keys) {
      final polygon = Polygon(
          polygonId: PolygonId(key),
          points: networkPolygonLocations[key].points,
          strokeColor: networkPolygonLocations[key].color,
          strokeWidth: 2,
          fillColor: networkPolygonLocations[key].color.withOpacity(0.35),
          zIndex: 9,
          onTap: () {
            print(authorityAreas
                .firstWhere((element) => element.id == key, orElse: () => null)
                ?.title);
          });
      _polygons[key] = polygon;
    }
  }

  _buildPolyline() async {
    currentPolyline.clear();
    currentPolyline.add(Polyline(
        polylineId: PolylineId("robot"),
        points: currentPositions,
        width: 2,
        visible: true,
        color: Colors.black.withOpacity(0.8),
        zIndex: 9,
        onTap: () {}));
  }

  _buildCircles() async {
    _circles.clear();

    var zoomLevel = await _controller.getZoomLevel();
    var count = 0;
    for (var point in currentPositions) {
      var circle = Circle(
          radius: 40 / (zoomLevel / 4),
          circleId: CircleId("id$count"),
          center: point,
          zIndex: 10,
          fillColor: CoreStyle.white,
          strokeColor: CoreStyle.white);
      count += 1;
      _circles.add(circle);
    }
  }

  _buildClosePolygonDrawing(Color polygonColor) {
    return Positioned(
        left: 40.w,
        bottom: 240.h,
        child: GestureDetector(
          onTap: () {
            var key = polygonLocations?.keys?.last ?? "1";
            polygonLocations["${int.tryParse(key) + 1}"] =
                ColoredPolygon(currentPositions, polygonColor);
            currentPositions = [];
            _buildPolygon();
            _buildPolyline();
            _buildCircles();
            if (isDrawingAuthorityMode == true) {
              isDrawingAuthorityMode = false;
              Provider.of<UserManagementChangeNotifier>(context, listen: false)
                  .showAddAuthorityArea = false;
              showEditAuthorityDetails = true;
            } else {
              isDrawingAreaMode = false;
              Provider.of<UserManagementChangeNotifier>(context, listen: false)
                  .showAddArea = false;
              BlocProvider.of<MapBloc>(context)
                  .add(GetRegions(NoParams(cancelToken: cancelToken)));
              BlocProvider.of<MapBloc>(context)
                  .add(GetRegionTypes(NoParams(cancelToken: cancelToken)));
              showEditAreaDetails = true;
            }
            Future.delayed(Duration(milliseconds: 100))
                .then((value) => setState(() {}));
          },
          child: Container(
            decoration: BoxDecoration(
                color: CoreStyle.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                      color: CoreStyle.operationGrayBackgroundColor
                          .withOpacity(0.1),
                      blurRadius: 4)
                ]),
            width: 180.w,
            height: 50.h,
            child: Center(
              child: Text(
                "Save",
                style: TextStyle(
                    color: CoreStyle.operationIncidentItemListBlackColor,
                    fontFamily: CoreStyle.fontWithWeight(FontWeight.w600),
                    fontSize: 16.sp),
              ),
            ),
          ),
        ));
  }

  _buildClearPolygonDrawing() {
    return Positioned(
        left: 40.w,
        bottom: 160.h,
        child: GestureDetector(
          onTap: () {
            currentPositions = [];
            _buildPolygon();
            _buildPolyline();
            _buildCircles();
            Future.delayed(Duration(milliseconds: 100))
                .then((value) => setState(() {}));
          },
          child: Container(
            decoration: BoxDecoration(
                color: CoreStyle.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                      color: CoreStyle.operationGrayBackgroundColor
                          .withOpacity(0.1),
                      blurRadius: 4)
                ]),
            width: 180.w,
            height: 50.h,
            child: Center(
              child: Text(
                "Clear Draw",
                style: TextStyle(
                    color: CoreStyle.operationIncidentItemListBlackColor,
                    fontFamily: CoreStyle.fontWithWeight(FontWeight.w600),
                    fontSize: 16.sp),
              ),
            ),
          ),
        ));
  }

  _buildRemoveLastPoint() {
    return Positioned(
        left: 40.w,
        bottom: 80.h,
        child: GestureDetector(
          onTap: () {
            currentPositions.removeLast();
            _buildPolygon();
            _buildPolyline();
            _buildCircles();
            Future.delayed(Duration(milliseconds: 100))
                .then((value) => setState(() {}));
          },
          child: Container(
            decoration: BoxDecoration(
                color: CoreStyle.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                      color: CoreStyle.operationGrayBackgroundColor
                          .withOpacity(0.1),
                      blurRadius: 4)
                ]),
            width: 180.w,
            height: 50.h,
            child: Center(
              child: Text(
                "Remove last",
                style: TextStyle(
                    color: CoreStyle.operationIncidentItemListBlackColor,
                    fontFamily: CoreStyle.fontWithWeight(FontWeight.w600),
                    fontSize: 16.sp),
              ),
            ),
          ),
        ));
  }

  refresh() => setState(() {});
}
