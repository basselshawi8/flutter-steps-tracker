import 'package:micropolis_test/core/entities/base_entity.dart';

class RewardEntity extends BaseEntity {
  RewardEntity({
    required this.price,
    required this.name,
  });

  final int price;
  final String name;

  @override
  List<Object?> get props => [this.price, this.name];
}
