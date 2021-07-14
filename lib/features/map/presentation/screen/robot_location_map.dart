import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';

class RobotLocationMap extends StatefulWidget {

  static const routeName = '/robotLocation';

  @override
  _RobotLocationMapState createState() {
    // TODO: implement createState
    return _RobotLocationMapState();
  }
}

class _RobotLocationMapState extends State<RobotLocationMap> {

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final locations = [LatLng(51.5074, 0.1278),LatLng(48.8566, 2.3522)];
    var icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, IMG_ROBOT_MARKER);

    setState(() {
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
          icon: icon
        );
        count += 1;
        _markers["robot $count"] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Robots Locations'),
        backgroundColor: CoreStyle.operationGreenContent,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,

        initialCameraPosition: CameraPosition(
          target: const LatLng(0, 0),
          zoom: 2,
        ),
        markers: _markers.values.toSet(),
      )
    );
  }
}
