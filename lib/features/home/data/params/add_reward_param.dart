import 'dart:convert';

import 'package:micropolis_test/core/params/base_params.dart';
import 'package:micropolis_test/features/home/data/model/my_reward_model.dart';

class AddRewardParam extends BaseParams {
  final MyRewardModel rewardModel;

  AddRewardParam({required this.rewardModel, cancelToken})
      : super(cancelToken: cancelToken);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => rewardModel.toMap();
}
