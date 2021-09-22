// To parse this JSON data, do
//
//     final createFacialModel = createFacialModelFromMap(jsonString);

import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

class CreateFacialModel extends BaseModel {
  CreateFacialModel({
    this.success,
    this.message,
    this.data,
  });

  final bool success;
  final String message;
  final FacialData data;

  factory CreateFacialModel.fromJson(String str) =>
      CreateFacialModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateFacialModel.fromMap(Map<String, dynamic> json) =>
      CreateFacialModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : FacialData.fromMap(json["data"]),
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

class FacialData extends BaseModel {
  FacialData({
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
  final String vehicleId;
  final int frAccuracyValue;
  final double frFrameSize;
  final int v;

  factory FacialData.fromJson(String str) =>
      FacialData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FacialData.fromMap(Map<String, dynamic> json) => FacialData(
        frActive: json["fr_active"] == null ? null : json["fr_active"],
        frProcessFrame:
            json["fr_process_frame"] == null ? null : json["fr_process_frame"],
        frCachedFaces:
            json["fr_cached_faces"] == null ? null : json["fr_cached_faces"],
        id: json["_id"] == null ? null : json["_id"],
        vehicleId: json["vehicle_id"] == null ? null : json["vehicle_id"],
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
        "vehicle_id": vehicleId == null ? null : vehicleId,
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
