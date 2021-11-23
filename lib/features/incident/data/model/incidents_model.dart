// To parse this JSON data, do
//
//     final incidentsModel = incidentsModelFromMap(jsonString);

import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

class IncidentsModel extends BaseModel {
  IncidentsModel({
    this.code,
    this.message,
    this.action,
    this.data,
  });

  final int code;
  final String message;
  final String action;
  final List<IncidentModel> data;

  factory IncidentsModel.fromJson(String str) =>
      IncidentsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IncidentsModel.fromMap(Map<String, dynamic> json) => IncidentsModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        action: json["action"] == null ? null : json["action"],
        data: json["data"] == null
            ? null
            : List<IncidentModel>.from(
                json["data"].map((x) => IncidentModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "action": action == null ? null : action,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toMap())),
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class IncidentModel extends BaseModel {
  IncidentModel({
    this.isWanted,
    this.sensivitiy,
    this.behaviorAnalysisClassification,
    this.id,
    this.publishedAt,
    this.videoIds,
    this.capturedPhotosIds,
    this.personId,
    this.percentageMap,
    this.longitude,
    this.latitude,
    this.dateRaise,
    this.classification,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.vehicle,
    this.datumId,
  });

  final bool isWanted;
  final num sensivitiy;
  final String behaviorAnalysisClassification;
  final String id;
  final DateTime publishedAt;
  final VideoIds videoIds;
  final CapturedPhotosIds capturedPhotosIds;
  final PersonId personId;
  final num percentageMap;
  final String longitude;
  final String latitude;
  final DateTime dateRaise;
  final String classification;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final VehicleModel vehicle;
  final String datumId;

  factory IncidentModel.fromJson(String str) =>
      IncidentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IncidentModel.fromMap(Map<String, dynamic> json) => IncidentModel(
        isWanted: json["is_wanted"] == null ? null : json["is_wanted"],
        sensivitiy:
            json["sensivitiy"] == null ? null : json["sensivitiy"].toDouble(),
        behaviorAnalysisClassification:
            json["behavior_analysis_classification"] == null
                ? null
                : json["behavior_analysis_classification"],
        id: json["_id"] == null ? null : json["_id"],
        publishedAt: json["published_at"] == null
            ? null
            : DateTime.parse(json["published_at"]),
        videoIds: json["video_ids"] == null
            ? null
            : VideoIds.fromMap(json["video_ids"]),
        capturedPhotosIds: json["captured_photos_ids"] == null
            ? null
            : CapturedPhotosIds.fromMap(json["captured_photos_ids"]),
        personId: json["person_id"] == null
            ? null
            : PersonId.fromMap(json["person_id"]),
        percentageMap:
            json["percentageMap"] == null ? null : json["percentageMap"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        dateRaise: json["dateRaise"] == null
            ? null
            : DateTime.parse(json["dateRaise"]),
        classification:
            json["classification"] == null ? null : json["classification"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
        vehicle: json["vehicle"] == null
            ? null
            : VehicleModel.fromMap(json["vehicle"]),
        datumId: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "is_wanted": isWanted == null ? null : isWanted,
        "sensivitiy": sensivitiy == null ? null : sensivitiy,
        "behavior_analysis_classification":
            behaviorAnalysisClassification == null
                ? null
                : behaviorAnalysisClassification,
        "_id": id == null ? null : id,
        "published_at":
            publishedAt == null ? null : publishedAt.toIso8601String(),
        "video_ids": videoIds == null ? null : videoIds.toMap(),
        "captured_photos_ids":
            capturedPhotosIds == null ? null : capturedPhotosIds.toMap(),
        "person_id": personId == null ? null : personId.toMap(),
        "percentageMap": percentageMap == null ? null : percentageMap,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "dateRaise": dateRaise == null
            ? null
            : "${dateRaise.year.toString().padLeft(4, '0')}-${dateRaise.month.toString().padLeft(2, '0')}-${dateRaise.day.toString().padLeft(2, '0')}",
        "classification": classification == null ? null : classification,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
        "vehicle": vehicle == null ? null : vehicle.toMap(),
        "id": datumId == null ? null : datumId,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class VehicleModel extends BaseModel {
  VehicleModel({
    this.isActive,
    this.id,
    this.name,
    this.vehicleVehicleId,
    this.vehicleCode,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.createdBy,
    this.updatedBy,
    this.vehicleId,
  });

  final bool isActive;
  final String id;
  final String name;
  final String vehicleVehicleId;
  final String vehicleCode;
  final dynamic publishedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String createdBy;
  final String updatedBy;
  final String vehicleId;

  factory VehicleModel.fromJson(String str) =>
      VehicleModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VehicleModel.fromMap(Map<String, dynamic> json) => VehicleModel(
        isActive: json["is_Active"] == null ? null : json["is_Active"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        vehicleVehicleId:
            json["vehicle_id"] == null ? null : json["vehicle_id"],
        vehicleCode: json["vehicle_code"] == null ? null : json["vehicle_code"],
        publishedAt: json["published_at"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        updatedBy: json["updated_by"] == null ? null : json["updated_by"],
        vehicleId: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "is_Active": isActive == null ? null : isActive,
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "vehicle_id": vehicleVehicleId == null ? null : vehicleVehicleId,
        "vehicle_code": vehicleCode == null ? null : vehicleCode,
        "published_at": publishedAt,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
        "created_by": createdBy == null ? null : createdBy,
        "updated_by": updatedBy == null ? null : updatedBy,
        "id": vehicleId == null ? null : vehicleId,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class CapturedPhotosIds extends BaseModel {
  CapturedPhotosIds({
    this.capArr,
  });

  final List<String> capArr;

  factory CapturedPhotosIds.fromJson(String str) =>
      CapturedPhotosIds.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CapturedPhotosIds.fromMap(Map<String, dynamic> json) =>
      CapturedPhotosIds(
        capArr: json["capArr"] == null
            ? null
            : List<String>.from(json["capArr"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "capArr":
            capArr == null ? null : List<dynamic>.from(capArr.map((x) => x)),
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class PersonId extends BaseModel {
  PersonId({
    this.perId,
  });

  final List<int> perId;

  factory PersonId.fromJson(String str) => PersonId.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonId.fromMap(Map<String, dynamic> json) => PersonId(
        perId: json["per_id"] == null
            ? null
            : json["per_id"] is List
                ? List<int>.from(json["per_id"].map((x) => x))
                : [json["per_id"]],
      );

  Map<String, dynamic> toMap() => {
        "per_id":
            perId == null ? null : List<dynamic>.from(perId.map((x) => x)),
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class VideoIds extends BaseModel {
  VideoIds({
    this.vidArr,
  });

  final List<String> vidArr;

  factory VideoIds.fromJson(String str) => VideoIds.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoIds.fromMap(Map<String, dynamic> json) => VideoIds(
        vidArr: json["vidArr"] == null
            ? null
            : List<String>.from(json["vidArr"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "vidArr":
            vidArr == null ? null : List<dynamic>.from(vidArr.map((x) => x)),
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
