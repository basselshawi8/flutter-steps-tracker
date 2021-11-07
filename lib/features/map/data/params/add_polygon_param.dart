import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micropolis_test/core/params/base_params.dart';
import 'package:micropolis_test/features/map/presentation/screen/polygon_drawer.dart';

class AddSensitiveLocationParam extends BaseParams {
  final List<LatLng> points;
  final List<String> nationality;
  final List<CriticalTime> days;
  final String name;
  final String region;
  final String region_type;
  final String authority_area;

  AddSensitiveLocationParam({this.points,
    this.nationality,
    this.days,
    this.name,
    this.region,
    this.region_type,
    this.authority_area,
    cancelToken})
      : super(cancelToken: cancelToken);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() =>
      {
        "name": name,
        "region":region,
        "region_type":region_type,
        "authority_area":authority_area,
        "polygon": {
          "type": "Polygon",
          "coordinates": [points.map((e) => [e.latitude, e.longitude]).toList()]
        },
        "constraints": days
            .map((e) =>
        {
          "day": e.day.toLowerCase(),
          "from": "${e.from.hour}:${e.from.minute}",
          "to": "${e.to.hour}:${e.to.minute}",
          "FlagSuspect": e.flagSuspect == true ? 1 : 0
        })
            .toList(),
        "nationalitiesSensit": nationality,

      };
}
