import 'dart:convert';

import 'package:micropolis_test/core/params/base_params.dart';

class IncidentsParam extends BaseParams {

  final String query;

  IncidentsParam({this.query, cancelToken}) : super(cancelToken: cancelToken);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {"select": this.query};

}