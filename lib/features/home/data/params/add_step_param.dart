import 'dart:convert';

import 'package:micropolis_test/core/params/base_params.dart';
import 'package:micropolis_test/features/home/data/model/steps_model.dart';

class AddStepsParam extends BaseParams {
  final StepsModel stepsModel;

  AddStepsParam({required this.stepsModel, cancelToken})
      : super(cancelToken: cancelToken);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => stepsModel.toMap();
}
