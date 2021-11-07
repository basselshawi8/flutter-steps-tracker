import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micropolis_test/core/params/base_params.dart';
import 'package:micropolis_test/features/map/presentation/screen/polygon_drawer.dart';

class AddAuthorityParam extends BaseParams {
  final List<LatLng> points;
  final String title;
  final String policeDepartment;

  AddAuthorityParam(
      {this.points,
        this.title,
        this.policeDepartment,
        cancelToken})
      : super(cancelToken: cancelToken);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "polygon": {
      "type": "Polygon",
      "coordinates":[ points.map((e) => [e.latitude, e.longitude]).toList()]
    },
    "police_dept": policeDepartment,
    "title": title
  };
}
