// To parse this JSON data, do
//
//     final getBehavioralAnalysisModel = getBehavioralAnalysisModelFromMap(jsonString);

import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

import 'get_facial_model.dart';

class GetBehavioralAnalysisModel extends BaseModel {
  GetBehavioralAnalysisModel({
    this.success,
    this.data,
  });

  final bool success;
  final BehavioralData data;

  factory GetBehavioralAnalysisModel.fromJson(String str) =>
      GetBehavioralAnalysisModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetBehavioralAnalysisModel.fromMap(Map<String, dynamic> json) =>
      GetBehavioralAnalysisModel(
        success: json["success"] == null ? null : json["success"],
        data:
            json["data"] == null ? null : BehavioralData.fromMap(json["data"]),
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

class BehavioralData extends BaseModel {
  BehavioralData({
    this.baImgSize,
    this.baImagesPerFile,
    this.baActive,
    this.id,
    this.vehicleId,
    this.v,
  });

  final int baImgSize;
  final int baImagesPerFile;
  final bool baActive;
  final String id;
  final VehicleId vehicleId;
  final int v;

  factory BehavioralData.fromJson(String str) =>
      BehavioralData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BehavioralData.fromMap(Map<String, dynamic> json) => BehavioralData(
        baImgSize: json["ba_img_size"] == null ? null : json["ba_img_size"],
        baImagesPerFile: json["ba_images_per_file"] == null
            ? null
            : json["ba_images_per_file"],
        baActive: json["ba_active"] == null ? null : json["ba_active"],
        id: json["_id"] == null ? null : json["_id"],
        vehicleId: json["vehicle_id"] == null
            ? null
            : VehicleId.fromMap(json["vehicle_id"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "ba_img_size": baImgSize == null ? null : baImgSize,
        "ba_images_per_file": baImagesPerFile == null ? null : baImagesPerFile,
        "ba_active": baActive == null ? null : baActive,
        "_id": id == null ? null : id,
        "vehicle_id": vehicleId == null ? null : vehicleId.toMap(),
        "__v": v == null ? null : v,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
