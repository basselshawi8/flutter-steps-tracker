import 'dart:convert';

import 'package:micropolis_test/core/params/base_params.dart';
import 'package:micropolis_test/features/home/data/model/health_point_model.dart';
import 'package:micropolis_test/features/home/data/model/steps_model.dart';

class AddHealthParam extends BaseParams {
  final HealthPointModel healthPointModel;

  AddHealthParam({required this.healthPointModel, cancelToken})
      : super(cancelToken: cancelToken);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => healthPointModel.toMap();
}
