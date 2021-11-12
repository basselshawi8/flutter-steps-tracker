import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';

class MiniMapWidget extends StatefulWidget {
  final LatLng location;

  const MiniMapWidget({Key key, this.location}) : super(key: key);

  @override
  _MiniMapWidgetState createState() {
    return _MiniMapWidgetState();
  }
}

class _MiniMapWidgetState extends State<MiniMapWidget> {
  GoogleMapController _controller;
  final Map<String, Marker> _markers = {};
  var isMini = true;
  var zoomLevel = 11.0;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    var _darkMapStyle = await rootBundle.loadString(MAP_DARK_STYLE);
    controller.setMapStyle(_darkMapStyle);
    _controller = controller;
  }

  Future<void> _redrawMarkers() async {
    _markers.clear();

    var icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, IMG_VEHICLE);
    final marker = Marker(
        markerId: MarkerId("robot 1"),
        position: widget.location,
        infoWindow: InfoWindow(
          title: "robot 1",
          snippet: "robot 1 position",
        ),
        icon: icon);
    _markers["robot 1"] = marker;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 450.h,
        left: 700.w,
        child: Container(
          width: isMini == true ? 200.w : 700.w,
          height: isMini == true ? 200.w : 600.w,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  width: isMini == true ? 200.w : 450.w,
                  height: isMini == true ? 200.w : 450.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF02A76F), width: 4.w),
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x0000007C),
                            blurRadius: 40,
                            offset: Offset(0, 10))
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: FutureBuilder(
                      future: _redrawMarkers(),
                      builder: (context, snapshot) {
                        return new GoogleMap(
                          onMapCreated: _onMapCreated,
                          compassEnabled: false,
                          zoomGesturesEnabled: false,
                          myLocationButtonEnabled: false,
                          initialCameraPosition: new CameraPosition(
                            target: widget.location ?? LatLng(33, 33),
                            zoom: zoomLevel,
                          ),
                          markers: _markers?.values?.toSet(),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned.fill(child: GestureDetector(onTap: () {
                setState(() {
                  isMini = !isMini;
                });
              })),
              if (isMini == false)
                Positioned(
                  bottom: 20.h,
                  right: 20.w,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (zoomLevel > 0) zoomLevel -= 1;
                          print(zoomLevel);
                          _controller
                              .animateCamera(CameraUpdate.zoomTo(zoomLevel));
                        },
                        child: Container(
                          width: 70.w,
                          height: 70.w,
                          decoration: BoxDecoration(
                              color: Color(0xff00CB85),
                              borderRadius: BorderRadius.circular(16.r)),
                          child: Icon(
                            Icons.remove,
                            color: CoreStyle.white,
                            size: 50.w,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          zoomLevel += 1;
                          print(zoomLevel);
                          _controller
                              .animateCamera(CameraUpdate.zoomTo(zoomLevel));
                        },
                        child: Container(
                          width: 70.w,
                          height: 70.w,
                          decoration: BoxDecoration(
                              color: Color(0xff00CB85),
                              borderRadius: BorderRadius.circular(16.r)),
                          child: Icon(
                            Icons.add,
                            color: CoreStyle.white,
                            size: 50.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ));
  }
}
