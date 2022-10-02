import 'package:micropolis_test/core/entities/base_entity.dart';

class MyRewardEntity extends BaseEntity {
  MyRewardEntity({
    required this.rewardName,
    required this.deviceId,
    required this.name,
    required this.price,
    this.date,
  });

  final String rewardName;
  final String deviceId;
  final String name;
  final int price;
  final DateTime? date;

  @override
  List<Object?> get props =>
      [this.rewardName, this.date, this.deviceId, this.name, this.price];
}
