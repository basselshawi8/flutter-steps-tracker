import 'dart:convert';

import 'package:micropolis_test/core/params/base_params.dart';

class IncidentsParam extends BaseParams {
  final String query;
  final int limit;
  final int page;
  final String lookup;
  final String sort;

  IncidentsParam(
      {this.limit, this.page, this.lookup, this.query, this.sort, cancelToken})
      : super(cancelToken: cancelToken);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "select": this.query,
        "limit": this.limit,
        "page": this.page,
        "lookup": "{${this.lookup}}",
      };
}
