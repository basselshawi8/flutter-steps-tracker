import 'package:micropolis_test/core/entities/base_entity.dart';

class HealthPointEntity extends BaseEntity {
  HealthPointEntity({
    required this.deviceId,
    required this.name,
    required this.used,
    this.date,
  });

  final String deviceId;
  final String name;
  final bool used;
  final DateTime? date;

  @override
  List<Object?> get props => [this.used, this.date, this.deviceId, this.name];
}
