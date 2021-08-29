import 'dart:convert';

import 'package:micropolis_test/core/params/base_params.dart';

class UpdateIncidentParam extends BaseParams {
  final String id;
  final String classification;

  UpdateIncidentParam({this.id, this.classification, cancelToken})
      : super(cancelToken: cancelToken);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {"classification": this.classification};
}
