import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/features/incident/presentation/notifiers/incidents_notifier.dart';
import 'package:micropolis_test/features/incident/presentation/widgets/suspect_data_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:micropolis_test/features/incident/presentation/widgets/incident_action_widget.dart';
import 'package:micropolis_test/features/incident/presentation/widgets/incident_subject_widget.dart';
import 'package:micropolis_test/features/incident/presentation/widgets/incidents_widget.dart';

import '../../../../main.dart';

class IncidentsScreen extends StatefulWidget {
  static const routeName = '/incidentsWindow';

  final LatLng location;
  final String type;

  const IncidentsScreen({Key key, this.location, this.type}) : super(key: key);

  @override
  _IncidentsScreenState createState() {
    return _IncidentsScreenState();
  }
}

class _IncidentsScreenState extends State<IncidentsScreen>
    with SingleTickerProviderStateMixin {
  LatLng localLocation;
  final Map<String, Marker> _markers = {};
  GoogleMapController _controller;

  List<LatLng> _locations = [LatLng(40.7831, -73.9712)];

  @override
  void initState() {
    localLocation = widget.location ?? LatLng(40.7831, -73.9712);

    /*WidgetsBinding.instance.addObserver(ResizeNotifier(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) Phoenix.rebirth(context);
      });
    }));*/

    super.initState();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    var _darkMapStyle = await rootBundle.loadString(MAP_DARK_STYLE);
    controller.setMapStyle(_darkMapStyle);
    _controller = controller;
  }

  _buildMarkers() {
    _markers.clear();
    Future.delayed(Duration(milliseconds: 250))
        .then((value) => _redrawMarkers());
  }

  _redrawMarkers() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, IMG_INCIDENT_PIN);
    var count = 1;
    for (var position in _locations) {
      final marker = Marker(
          markerId: MarkerId("robot $count"),
          position: position,
          infoWindow: InfoWindow(
            title: "robot $count",
            snippet: "robot $count position",
          ),
          icon: icon);
      count += 1;
      _markers["robot $count"] = marker;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<IncidentsChangeNotifier>(
          builder: (context, state, _) {
            if (state.currentIncident != null) {
              var stateLocation = LatLng(
                  double.tryParse(state.currentIncident.latitude),
                  double.tryParse(state.currentIncident.longitude));
              if (_locations.first != stateLocation) {
                _controller
                    .animateCamera(CameraUpdate.newLatLng(stateLocation));
                _locations.clear();
                _locations.add(stateLocation);
                _buildMarkers();
              }
            }
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Stack(
                children: [
                  Positioned.fill(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      right: 800.w,
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
                        child: Consumer<IncidentsChangeNotifier>(
                          builder: (context, state, _) {
                            if (state.imageCap == null ||
                                state.imageCap.length < 40) {
                              return Image.asset(
                                IMG_PERSON,
                                width: 250.w,
                                height: 250.w,
                                fit: BoxFit.cover,
                              );
                            } else {
                              Uint8List bytes = base64Decode(
                                  state.currentIncident == null
                                      ? state.imageCap
                                          .split("data:image/png;base64,")[1]
                                      : state.currentIncident.imageCap
                                          .split("data:image/png;base64,")[1]);
                              return Image.memory(
                                bytes,
                                width: 250.w,
                                height: 250.w,
                                fit: BoxFit.cover,
                              );
                            }
                          },
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      )),
                  Positioned(
                      top: 25.h,
                      left: 300.w,
                      child: ClipRRect(
                        child: Consumer<IncidentsChangeNotifier>(
                          builder: (context, state, _) {
                            if (state.imageMatch == null ||
                                state.imageMatch.length < 40) {
                              return Image.asset(
                                IMG_PERSON,
                                width: 120.w,
                                height: 120.w,
                                fit: BoxFit.cover,
                              );
                            } else {
                              Uint8List bytes = base64Decode(
                                  state.currentIncident == null
                                      ? state.imageMatch
                                          .split("data:image/png;base64,")[1]
                                      : state.currentIncident.imageMatch
                                          .split("data:image/png;base64,")[1]);
                              return Image.memory(
                                bytes,
                                width: 120.w,
                                height: 120.w,
                                fit: BoxFit.cover,
                              );
                            }
                          },
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      )),
                  IncidentsListWidget(
                    type: widget.type,
                  ),
                  IncidentSubjectWidget(),
                  IncidentActionsWidget(
                    incidentID: state?.currentIncident?.id ?? "",
                  ),
                  if (state.showSubjectData == true) SuspectDataWidget()
                ],
              ),
            );
          },
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