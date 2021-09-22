

import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

class CreateBehavioralModel extends BaseModel{
  CreateBehavioralModel({
    this.success,
    this.message,
    this.data,
  });

  final bool success;
  final String message;
  final BehavioralData data;

  factory CreateBehavioralModel.fromJson(String str) => CreateBehavioralModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateBehavioralModel.fromMap(Map<String, dynamic> json) => CreateBehavioralModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : BehavioralData.fromMap(json["data"]),
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

class BehavioralData extends BaseModel{
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
  final String vehicleId;
  final int v;

  factory BehavioralData.fromJson(String str) => BehavioralData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BehavioralData.fromMap(Map<String, dynamic> json) => BehavioralData(
    baImgSize: json["ba_img_size"] == null ? null : json["ba_img_size"],
    baImagesPerFile: json["ba_images_per_file"] == null ? null : json["ba_images_per_file"],
    baActive: json["ba_active"] == null ? null : json["ba_active"],
    id: json["_id"] == null ? null : json["_id"],
    vehicleId: json["vehicle_id"] == null ? null : json["vehicle_id"],
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "ba_img_size": baImgSize == null ? null : baImgSize,
    "ba_images_per_file": baImagesPerFile == null ? null : baImagesPerFile,
    "ba_active": baActive == null ? null : baActive,
    "_id": id == null ? null : id,
    "vehicle_id": vehicleId == null ? null : vehicleId,
    "__v": v == null ? null : v,
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
