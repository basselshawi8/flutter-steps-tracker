// To parse this JSON data, do
//
//     final stepsModel = stepsModelFromMap(jsonString);

import 'dart:convert';

import 'package:micropolis_test/core/models/BaseModel.dart';
import 'package:micropolis_test/features/home/domain/entity/health_point_entity.dart';
import 'package:micropolis_test/features/home/domain/entity/steps_entity.dart';

class HealthPointModel extends BaseModel<HealthPointEntity> {
  HealthPointModel({
    required this.used,
    required this.name,
    required this.deviceId,
    this.date,
  });

  final bool used;
  final DateTime? date;
  final String deviceId;
  final String name;

  factory HealthPointModel.fromJson(String str) =>
      HealthPointModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HealthPointModel.fromMap(Map<String, dynamic> json) =>
      HealthPointModel(
        used: json["used"] == null ? null : json["used"],
        deviceId: json["deviceId"] == null ? null : json["deviceId"],
        name: json["name"] == null ? null : json["name"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "used": used,
        "deviceId": deviceId,
        "name": name,
        "date": date == null ? null : date?.toIso8601String(),
      };

  @override
  HealthPointEntity toEntity() {
    return HealthPointEntity(
        used: this.used,
        date: this.date,
        name: this.name,
        deviceId: this.deviceId);
  }
}
