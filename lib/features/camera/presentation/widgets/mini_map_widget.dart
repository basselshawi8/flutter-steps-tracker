import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/features/camera/presentation/notifiers/actions_change_notifier.dart';
import 'package:micropolis_test/main.dart';
import 'package:provider/provider.dart';

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
  LatLng _currentLocation;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    var _darkMapStyle = await rootBundle.loadString(MAP_DARK_STYLE);
    controller.setMapStyle(_darkMapStyle);
    _controller = controller;
  }

  Future<void> _redrawMarkers() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, IMG_VEHICLE);
    if (_markers.isNotEmpty) _markers.clear();
    final marker = Marker(
        markerId: MarkerId("m2"),
        position: _currentLocation,
        infoWindow: InfoWindow(
          title: "m2",
          snippet: "m2 position",
        ),
        icon: icon);
    _markers["m2"] = marker;
  }

  @override
  void initState() {
    _currentLocation = widget.location;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: Provider.of<ActionsChangeNotifier>(context).rcMode == true
            ? 370.h
            : 22.h,
        left: 30.w,
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
                        return StreamBuilder(
                          stream: mqttHelper.locationReceived,
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data is LatLng) {
                              var coordinate = snapshot.data as LatLng;
                              _currentLocation = coordinate;
                              _redrawMarkers();

                              _controller.animateCamera(
                                  CameraUpdate.newLatLngZoom(
                                      coordinate, zoomLevel));
                            }
                            return new GoogleMap(
                              onMapCreated: _onMapCreated,
                              compassEnabled: false,
                              zoomControlsEnabled: false,
                              zoomGesturesEnabled: false,
                              myLocationButtonEnabled: false,
                              initialCameraPosition: new CameraPosition(
                                target: _currentLocation ?? LatLng(33, 33),
                                zoom: zoomLevel,
                              ),
                              markers: _markers?.values?.toSet(),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              if (isMini == false)
                Positioned(
                    top: 24.w,
                    left: 24.w,
                    child: Container(
                      height: 70.h,
                      width: 300.w,
                      padding: EdgeInsets.only(right: 30.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.w),
                          color: Color(0xff00CB85)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            mqttHelper.vehiclePrefix.toUpperCase(),
                            style: TextStyle(
                                color: CoreStyle.white,
                                fontFamily:
                                    CoreStyle.fontWithWeight(FontWeight.w400),
                                fontSize: 38.sp),
                          )
                        ],
                      ),
                    )),
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
