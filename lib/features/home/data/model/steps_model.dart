// To parse this JSON data, do
//
//     final stepsModel = stepsModelFromMap(jsonString);

import 'dart:convert';

import 'package:micropolis_test/core/models/BaseModel.dart';
import 'package:micropolis_test/features/home/domain/entity/steps_entity.dart';

class StepsModel extends BaseModel<StepsEntity> {
  StepsModel({
    required this.steps,
    required this.name,
    required this.deviceId,
    this.date,
  });

  final int steps;
  final DateTime? date;
  final String deviceId;
  final String name;

  factory StepsModel.fromJson(String str) =>
      StepsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StepsModel.fromMap(Map<String, dynamic> json) => StepsModel(
        steps: json["steps"] == null ? null : json["steps"],
        deviceId: json["deviceId"] == null ? 'something' : json["deviceId"],
        name: json["name"] == null ? 'unknown' : json["name"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "steps": steps,
        "deviceId": deviceId,
        "name": name,
        "date": date == null ? null : date?.toIso8601String(),
      };

  @override
  StepsEntity toEntity() {
    return StepsEntity(
        steps: this.steps,
        date: this.date,
        name: this.name,
        deviceId: this.deviceId);
  }
}
