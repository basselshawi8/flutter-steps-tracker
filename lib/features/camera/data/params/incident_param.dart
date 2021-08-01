import 'dart:convert';

import 'package:micropolis_test/core/params/base_params.dart';

class IncidentParam extends BaseParams {
  final String incidentID;

  IncidentParam({this.incidentID, cancelToken}) : super(cancelToken: cancelToken);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {"id": this.incidentID};
}
