import 'dart:convert';

import 'package:micropolis_test/core/params/base_params.dart';

class SubjectsParam extends BaseParams {
  final List<int> ids;

  SubjectsParam({this.ids, cancelToken}) : super(cancelToken: cancelToken);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "subjects": this.ids,
      };
}
