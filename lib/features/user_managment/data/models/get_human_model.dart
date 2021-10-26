import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

import 'get_facial_model.dart';

class GetHumanDetectionModel extends BaseModel {
  GetHumanDetectionModel({
    this.success,
    this.data,
  });

  final bool success;
  final HumanData data;

  factory GetHumanDetectionModel.fromJson(String str) =>
      GetHumanDetectionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetHumanDetectionModel.fromMap(Map<String, dynamic> json) =>
      GetHumanDetectionModel(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : HumanData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toMap(),
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class HumanData extends BaseModel {
  HumanData({
    this.id,
    this.vehicleId,
    this.hd,
    this.v,
  });

  final String id;
  final VehicleId vehicleId;
  final int hd;
  final int v;

  factory HumanData.fromJson(String str) => HumanData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HumanData.fromMap(Map<String, dynamic> json) => HumanData(
        id: json["_id"] == null ? null : json["_id"],
        vehicleId: json["vehicle_id"] == null
            ? null
            : VehicleId.fromMap(json["vehicle_id"]),
        hd: json["HD"] == null ? null : json["HD"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "vehicle_id": vehicleId == null ? null : vehicleId.toMap(),
        "HD": hd == null ? null : hd,
        "__v": v == null ? null : v,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
