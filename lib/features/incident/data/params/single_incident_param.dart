import 'dart:convert';

import 'package:micropolis_test/core/params/base_params.dart';

class SingleIncidentParam extends BaseParams {
  final String id;

  SingleIncidentParam({this.id, cancelToken}) : super(cancelToken: cancelToken);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": this.id,
      };
}
