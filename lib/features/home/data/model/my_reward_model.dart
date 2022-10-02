import 'dart:convert';

import 'package:micropolis_test/core/models/BaseModel.dart';
import 'package:micropolis_test/features/home/domain/entity/my_reward_entity.dart';
import 'package:micropolis_test/features/home/domain/entity/steps_entity.dart';

class MyRewardModel extends BaseModel<MyRewardEntity> {
  MyRewardModel({
    required this.rewardName,
    required this.name,
    required this.deviceId,
    required this.price,
    this.date,
  });

  final String rewardName;
  final DateTime? date;
  final String deviceId;
  final String name;
  final int price;

  factory MyRewardModel.fromJson(String str) =>
      MyRewardModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyRewardModel.fromMap(Map<String, dynamic> json) => MyRewardModel(
        rewardName: json["rewardName"] == null ? null : json["rewardName"],
        deviceId: json["deviceId"] == null ? 'something' : json["deviceId"],
        name: json["name"] == null ? 'unknown' : json["name"],
        price: json["price"] == null ? null : json["price"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "rewardName": rewardName,
        "deviceId": deviceId,
        "price": price,
        "name": name,
        "date": date == null ? null : date?.toIso8601String(),
      };

  @override
  MyRewardEntity toEntity() {
    return MyRewardEntity(
        rewardName: this.rewardName,
        date: this.date,
        price:this.price,
        name: this.name,
        deviceId: this.deviceId);
  }
}
