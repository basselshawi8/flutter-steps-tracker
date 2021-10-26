import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

class GetFacialRecognitionModel extends BaseModel {
  GetFacialRecognitionModel({
    this.success,
    this.data,
  });

  final bool success;
  final GetFacialData data;

  factory GetFacialRecognitionModel.fromJson(String str) =>
      GetFacialRecognitionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetFacialRecognitionModel.fromMap(Map<String, dynamic> json) =>
      GetFacialRecognitionModel(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : GetFacialData.fromMap(json["data"]),
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

class GetFacialData extends BaseModel {
  GetFacialData({
    this.frActive,
    this.frProcessFrame,
    this.frCachedFaces,
    this.id,
    this.vehicleId,
    this.frAccuracyValue,
    this.frFrameSize,
    this.v,
  });

  final bool frActive;
  final int frProcessFrame;
  final int frCachedFaces;
  final String id;
  final VehicleId vehicleId;
  final int frAccuracyValue;
  final double frFrameSize;
  final int v;

  factory GetFacialData.fromJson(String str) =>
      GetFacialData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetFacialData.fromMap(Map<String, dynamic> json) => GetFacialData(
        frActive: json["fr_active"] == null ? null : json["fr_active"],
        frProcessFrame:
            json["fr_process_frame"] == null ? null : json["fr_process_frame"],
        frCachedFaces:
            json["fr_cached_faces"] == null ? null : json["fr_cached_faces"],
        id: json["_id"] == null ? null : json["_id"],
        vehicleId: json["vehicle_id"] == null
            ? null
            : VehicleId.fromMap(json["vehicle_id"]),
        frAccuracyValue: json["fr_accuracy_value"] == null
            ? null
            : json["fr_accuracy_value"],
        frFrameSize: json["fr_frame_size"] == null
            ? null
            : json["fr_frame_size"].toDouble(),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "fr_active": frActive == null ? null : frActive,
        "fr_process_frame": frProcessFrame == null ? null : frProcessFrame,
        "fr_cached_faces": frCachedFaces == null ? null : frCachedFaces,
        "_id": id == null ? null : id,
        "vehicle_id": vehicleId == null ? null : vehicleId.toMap(),
        "fr_accuracy_value": frAccuracyValue == null ? null : frAccuracyValue,
        "fr_frame_size": frFrameSize == null ? null : frFrameSize,
        "__v": v == null ? null : v,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class VehicleId extends BaseModel {
  VehicleId({
    this.isActive,
    this.id,
    this.name,
    this.vehicleId,
    this.vehicleCode,
    this.v,
  });

  final bool isActive;
  final String id;
  final String name;
  final String vehicleId;
  final String vehicleCode;
  final int v;

  factory VehicleId.fromJson(String str) => VehicleId.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VehicleId.fromMap(Map<String, dynamic> json) => VehicleId(
        isActive: json["is_Active"] == null ? null : json["is_Active"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        vehicleId: json["vehicle_id"] == null ? null : json["vehicle_id"],
        vehicleCode: json["vehicle_code"] == null ? null : json["vehicle_code"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "is_Active": isActive == null ? null : isActive,
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "vehicle_id": vehicleId == null ? null : vehicleId,
        "vehicle_code": vehicleCode == null ? null : vehicleCode,
        "__v": v == null ? null : v,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
