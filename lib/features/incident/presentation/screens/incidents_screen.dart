import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/services.dart' show rootBundle;

class IncidentsScreen extends StatefulWidget {
  static const routeName = '/incidentsWindow';

  final LatLng location;

  const IncidentsScreen({Key key, this.location}) : super(key: key);

  @override
  _IncidentsScreenState createState() {
    return _IncidentsScreenState();
  }
}

class _IncidentsScreenState extends State<IncidentsScreen>
    with SingleTickerProviderStateMixin {
  LatLng localLocation;
  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    localLocation = widget.location ?? LatLng(0, 0);

    WidgetsBinding.instance.addObserver(ResizeNotifier(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) Phoenix.rebirth(context);
      });
    }));

    super.initState();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    var _darkMapStyle = await rootBundle.loadString(MAP_DARK_STYLE);
    controller.setMapStyle(_darkMapStyle);

    final locations = [LatLng(51.5074, 0.1278), LatLng(48.8566, 2.3522)];
    var icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, IMG_ROBOT_MARKER);

    setState(() {
      /*_markers.clear();
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
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            children: [
              Positioned.fill(
                  child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: localLocation,
                  zoom: 12,
                ),
                markers: _markers.values.toSet(),
              )),
              Positioned(
                  top: 25.h,
                  left: 30.w,
                  child: ClipRRect(
                    child: Image.asset(
                      IMG_PERSON,
                      width: 250.w,
                      height: 250.w,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  )),
              Positioned(
                  top: 25.h,
                  left: 300.w,
                  child: ClipRRect(
                    child: Image.asset(
                      IMG_PERSON,
                      width: 120.w,
                      height: 120.w,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  ))
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}

class ResizeNotifier with WidgetsBindingObserver {
  final Function callBack;

  ResizeNotifier(this.callBack);

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    callBack();
  }
}
