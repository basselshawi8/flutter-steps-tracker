import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/core/extensions/latLng_extension.dart';

class RobotLocationMap extends StatefulWidget {
  static const routeName = '/robotLocation';

  @override
  _RobotLocationMapState createState() {
    // TODO: implement createState
    return _RobotLocationMapState();
  }
}

class _RobotLocationMapState extends State<RobotLocationMap> {
  GoogleMapController _controller;
  final Map<String, Marker> _markers = {};

  final Map<String, Polygon> _polygons = {};

  var locations = [LatLng(51.5074, 0.1278), LatLng(48.8566, 2.3522)];
  Map<String, List<LatLng>> polygonLocations = {"1": []};

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
          strokeWidth: 2,
          fillColor: Colors.blue.withOpacity(0.15),
          strokeColor: Colors.yellow,
          onTap: () {});
      count += 1;
      _polygons["robot $count"] = polygon;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Robots Locations'),
          backgroundColor: CoreStyle.operationGreenContent,
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: const LatLng(40.7831, -73.9712),
                  zoom: 12,
                ),
                polygons: _polygons.values.toSet(),
                markers: _markers.values.toSet(),
              ),
            ),
            Positioned.fill(child: GestureDetector(onTapUp: (details) async {
              var latLong = await _controller.getLatLng(ScreenCoordinate(
                  x: details.localPosition.dx.toInt(),
                  y: details.localPosition.dy.toInt()));

              var key = polygonLocations?.keys?.last ?? "1";

              if (polygonLocations[key] == null ||
                  polygonLocations[key].length == 0) {
                polygonLocations[key] = [latLong];
              } else {
                var firstLat = polygonLocations[key].first;
                var dist = firstLat.dist(latLong);

                print(dist);
                if (dist < 0.15) {
                  polygonLocations["${int.tryParse(key) + 1}"] = [];
                } else {
                  polygonLocations[key].add(latLong);
                }
              }
              _buildPolygon();
              Future.delayed(Duration(milliseconds: 100))
                  .then((value) => setState(() {}));
            }))
          ],
        ));
  }
}
