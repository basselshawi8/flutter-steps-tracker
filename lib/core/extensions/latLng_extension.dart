import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

extension distance on LatLng {
  double dist(LatLng point2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((point2.latitude - this.latitude) * p) / 2 +
        c(this.latitude * p) *
            c(point2.latitude * p) *
            (1 - c((point2.longitude - this.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }
}
