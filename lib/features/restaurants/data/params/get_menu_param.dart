import 'dart:convert';

import 'package:micropolis_test/core/params/base_params.dart';

class GetMenuParam extends BaseParams {
  final int restaurantID;

  GetMenuParam({this.restaurantID, cancelToken}) : super(cancelToken: cancelToken);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {"id": this.restaurantID};
}
