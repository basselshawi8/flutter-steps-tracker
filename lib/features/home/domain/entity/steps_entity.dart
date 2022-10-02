import 'package:micropolis_test/core/entities/base_entity.dart';

class StepsEntity extends BaseEntity {
  StepsEntity({
    required this.steps,
    required this.deviceId,
    required this.name,
    this.date,
  });

  final int steps;
  final String deviceId;
  final String name;
  final DateTime? date;

  @override
  List<Object?> get props => [this.steps, this.date, this.deviceId, this.name];
}
