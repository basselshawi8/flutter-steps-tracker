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
import 'package:micropolis_test/features/map/data/models/polygons_model.dart';
import 'package:micropolis_test/features/map/presentation/bloc/bloc.dart';
import 'package:micropolis_test/features/map/presentation/ui_extension/edit_polygon_extension.dart';

class CriticalTime {
  final TimeOfDay from;
  final TimeOfDay to;
  final String day;
  final bool flagSuspect;

  CriticalTime(this.from, this.to, this.day, this.flagSuspect);
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

  var isDrawingMode = false;
  var severityValue = "1";
  var showEditPolygonDetails = false;
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

  Map<String, List<LatLng>> polygonLocations = {"1": []};

  Map<String, List<LatLng>> networkPolygonLocations = {};

  @override
  void dispose() {
    cancelToken.cancel();
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<MapBloc>(context)
        .add(GetPolygons(NoParams(cancelToken: cancelToken)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map Drawer'),
          backgroundColor: CoreStyle.operationGreenContent,
        ),
        body: BlocBuilder<MapBloc, MapState>(
          buildWhen: (prev, next) {
            if (next is GetPolygonsWaitingState ||
                next is GetPolygonsSuccessState ||
                next is GetPolygonsFailureState) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            if (state is GetPolygonsWaitingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetPolygonsFailureState) {
              return ErrorScreenWidget(
                error: state.error,
                state: state,
              );
            } else if (state is GetPolygonsSuccessState) {
              return _buildContent(state.polygonModel);
            } else {
              return Container();
            }
          },
        ));
  }

  _buildContent(PolygonsModel model) {
    networkPolygonLocations.clear();
    for (var poly in model.data) {
      networkPolygonLocations[poly.id] = poly.polygon.coordinates.first
          .map((e) => LatLng(e[0], e[1]))
          .toList();
    }
    _buildPolygon();

    return Stack(
      children: [
        Positioned.fill(
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: const LatLng(40.7831, -73.9712),
              zoom: 12,
            ),
            polylines: currentPolyline.toSet(),
            polygons: _polygons.values.toSet(),
            circles: _circles.toSet(),
            markers: _markers.values.toSet(),
          ),
        ),
        Positioned.fill(child: GestureDetector(onTapUp: (details) async {
          if (isDrawingMode == false) {
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
              polygonLocations["${int.tryParse(key) + 1}"] = currentPositions;
              currentPositions = [];
              isDrawingMode = false;
              showEditPolygonDetails = true;
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
        _buildStartPolygonDrawing(),
        _buildClearPolygonDrawing(),
        _buildClosePolygonDrawing(),
        _buildRemoveLastPoint(),
        if (showEditPolygonDetails == true) editPolygonDetails()
      ],
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    var _darkMapStyle = await rootBundle.loadString(MAP_DARK_STYLE);
    controller.setMapStyle(_darkMapStyle);

    _buildMarkers();
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
          points: polygonLocations[key],
          strokeColor: CoreStyle.operationBlackColor,
          strokeWidth: 2,
          fillColor: CoreStyle.operationMapPolygonColor.withOpacity(0.35),
          zIndex: 9,
          onTap: () {});
      count += 1;
      _polygons["robot $count"] = polygon;
    }

    for (var key in networkPolygonLocations.keys) {
      final polygon = Polygon(
          polygonId: PolygonId(key),
          points: networkPolygonLocations[key],
          strokeColor: CoreStyle.operationBlackColor,
          strokeWidth: 2,
          fillColor: CoreStyle.operationMapPolygonColor.withOpacity(0.35),
          zIndex: 9,
          onTap: () {
            print(key);
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

  _buildStartPolygonDrawing() {
    return Positioned(
        left: 40.w,
        top: 40.h,
        child: GestureDetector(
          onTap: () {
            isDrawingMode = true;
          },
          child: Container(
            decoration: BoxDecoration(
              color: CoreStyle.operationBlack2Color.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12.r),
            ),
            width: 180.w,
            height: 50.h,
            child: Center(
              child: Text(
                "Start Draw",
                style: TextStyle(color: CoreStyle.white),
              ),
            ),
          ),
        ));
  }

  _buildClosePolygonDrawing() {
    return Positioned(
        left: 40.w,
        top: 100.h,
        child: GestureDetector(
          onTap: () {
            var key = polygonLocations?.keys?.last ?? "1";
            polygonLocations["${int.tryParse(key) + 1}"] = currentPositions;
            currentPositions = [];
            _buildPolygon();
            _buildPolyline();
            _buildCircles();
            isDrawingMode = false;
            showEditPolygonDetails = true;
            Future.delayed(Duration(milliseconds: 100))
                .then((value) => setState(() {}));
          },
          child: Container(
            decoration: BoxDecoration(
              color: CoreStyle.operationBlack2Color.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12.r),
            ),
            width: 180.w,
            height: 50.h,
            child: Center(
              child: Text(
                "Close Polygon",
                style: TextStyle(color: CoreStyle.white),
              ),
            ),
          ),
        ));
  }

  _buildClearPolygonDrawing() {
    return Positioned(
        left: 40.w,
        top: 160.h,
        child: GestureDetector(
          onTap: () {
            isDrawingMode = false;
            currentPositions = [];
            _buildPolygon();
            _buildPolyline();
            _buildCircles();
            Future.delayed(Duration(milliseconds: 100))
                .then((value) => setState(() {}));
          },
          child: Container(
            decoration: BoxDecoration(
              color: CoreStyle.operationBlack2Color.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12.r),
            ),
            width: 180.w,
            height: 50.h,
            child: Center(
              child: Text(
                "Clear Draw",
                style: TextStyle(color: CoreStyle.white),
              ),
            ),
          ),
        ));
  }

  _buildRemoveLastPoint() {
    return Positioned(
        left: 40.w,
        top: 220.h,
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
              color: CoreStyle.operationBlack2Color.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12.r),
            ),
            width: 180.w,
            height: 50.h,
            child: Center(
              child: Text(
                "Remove last",
                style: TextStyle(color: CoreStyle.white),
              ),
            ),
          ),
        ));
  }

  refresh() => setState(() {});
}
