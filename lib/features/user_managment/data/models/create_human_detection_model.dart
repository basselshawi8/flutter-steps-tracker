import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

class CreateHumanDetectionModel extends BaseModel{
  CreateHumanDetectionModel({
    this.success,
    this.message,
    this.data,
  });

  final bool success;
  final String message;
  final HumanDetectionData data;

  factory CreateHumanDetectionModel.fromJson(String str) =>
      CreateHumanDetectionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateHumanDetectionModel.fromMap(Map<String, dynamic> json) =>
      CreateHumanDetectionModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : HumanDetectionData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toMap(),
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class HumanDetectionData extends BaseModel {
  HumanDetectionData({
    this.id,
    this.vehicleId,
    this.hd,
    this.v,
  });

  final String id;
  final String vehicleId;
  final int hd;
  final int v;

  factory HumanDetectionData.fromJson(String str) =>
      HumanDetectionData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HumanDetectionData.fromMap(Map<String, dynamic> json) =>
      HumanDetectionData(
        id: json["_id"] == null ? null : json["_id"],
        vehicleId: json["vehicle_id"] == null ? null : json["vehicle_id"],
        hd: json["HD"] == null ? null : json["HD"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "vehicle_id": vehicleId == null ? null : vehicleId,
        "HD": hd == null ? null : hd,
        "__v": v == null ? null : v,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
