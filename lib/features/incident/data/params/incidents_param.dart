import 'dart:convert';

import 'package:micropolis_test/core/params/base_params.dart';

class IncidentsParam extends BaseParams {

  final String sort;
  final String populate;

  IncidentsParam(
      {this.sort, this.populate, cancelToken})
      : super(cancelToken: cancelToken);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "_sort:${this.sort}": "",
        "populate": this.populate,
      };
}
