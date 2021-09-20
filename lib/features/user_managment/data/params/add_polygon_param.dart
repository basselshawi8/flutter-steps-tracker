import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micropolis_test/core/params/base_params.dart';
import 'package:micropolis_test/features/map/presentation/screen/polygon_drawer.dart';

class AddPolygonParam extends BaseParams {
  final List<LatLng> points;
  final int weight;
  final List<String> nationality;
  final List<CriticalTime> days;
  final String name;

  AddPolygonParam(
      {this.points,
      this.weight,
      this.nationality,
      this.days,
      this.name,
      cancelToken})
      : super(cancelToken: cancelToken);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "Polygon": {
          "name": name,
          "coordinates": points.map((e) => [e.latitude, e.longitude]).toList()
        },
        "time": days
            .map((e) => {
                  "day": e.day.toLowerCase(),
                  "from": "${e.from.hour}:${e.from.minute}",
                  "to": "${e.to.hour}:${e.to.minute}",
                  "FlagSuspect": e.flagSuspect == true ? 1 : 0
                })
            .toList(),
        "nationality": nationality,
        "Wight": weight
      };
}
