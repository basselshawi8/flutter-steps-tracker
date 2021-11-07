// To parse this JSON data, do
//
//     final subAreaData = subAreaDataFromMap(jsonString);

import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

import 'authority_area_model.dart';

class SensitiveLocationModel extends BaseModel{
  SensitiveLocationModel({
    this.code,
    this.message,
    this.action,
    this.data,
  });

  final int code;
  final String message;
  final String action;
  final SubAreaData data;

  factory SensitiveLocationModel.fromJson(String str) => SensitiveLocationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SensitiveLocationModel.fromMap(Map<String, dynamic> json) => SensitiveLocationModel(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    action: json["action"] == null ? null : json["action"],
    data: json["data"] == null ? null : SubAreaData.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "action": action == null ? null : action,
    "data": data == null ? null : data.toMap(),
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class GetSensitiveLocationModel extends BaseModel {
  GetSensitiveLocationModel({
    this.data,
  });

  final List<SubAreaData> data;

  factory GetSensitiveLocationModel.fromJson(String str) =>
      GetSensitiveLocationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetSensitiveLocationModel.fromMap(List<dynamic> json) =>
      GetSensitiveLocationModel(
        data: json == null
            ? null
            : List<SubAreaData>.from(json.map((x) => SubAreaData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
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

class SubAreaData extends BaseModel {
  SubAreaData({
    this.id,
    this.name,
    this.constraints,
    this.nationalitiesSensit,
    this.polygon,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.authorityArea,
    this.region,
    this.regionType,
    this.subAreaDatumId,
  });

  final String id;
  final String name;
  final List<ConstraintData> constraints;
  final List<String> nationalitiesSensit;
  final PolygonData polygon;
  final DateTime publishedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final dynamic authorityArea;
  final dynamic region;
  final dynamic regionType;
  final String subAreaDatumId;

  factory SubAreaData.fromJson(String str) =>
      SubAreaData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubAreaData.fromMap(Map<String, dynamic> json) => SubAreaData(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        constraints: json["constraints"] == null
            ? null
            : List<ConstraintData>.from(
                json["constraints"].map((x) => ConstraintData.fromMap(x))),
        nationalitiesSensit: json["nationalitiesSensit"] == null
            ? null
            : List<String>.from(json["nationalitiesSensit"].map((x) => x)),
        polygon: json["polygon"] == null
            ? null
            : PolygonData.fromMap(json["polygon"]),
        publishedAt: json["published_at"] == null
            ? null
            : DateTime.parse(json["published_at"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
        authorityArea: json["authority_area"],
        region: json["region"],
        regionType: json["region_type"],
        subAreaDatumId: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "constraints": constraints == null
            ? null
            : List<dynamic>.from(constraints.map((x) => x.toMap())),
        "nationalitiesSensit": nationalitiesSensit == null
            ? null
            : List<dynamic>.from(nationalitiesSensit.map((x) => x)),
        "polygon": polygon == null ? null : polygon.toMap(),
        "published_at":
            publishedAt == null ? null : publishedAt.toIso8601String(),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
        "authority_area": authorityArea,
        "region": region,
        "region_type": regionType,
        "id": subAreaDatumId == null ? null : subAreaDatumId,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class ConstraintData extends BaseModel {
  ConstraintData({
    this.day,
    this.from,
    this.to,
    this.flagSuspect,
  });

  final String day;
  final String from;
  final String to;
  final int flagSuspect;

  factory ConstraintData.fromJson(String str) =>
      ConstraintData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConstraintData.fromMap(Map<String, dynamic> json) => ConstraintData(
        day: json["day"] == null ? null : json["day"],
        from: json["from"] == null ? null : json["from"],
        to: json["to"] == null ? null : json["to"],
        flagSuspect: json["FlagSuspect"] == null ? null : json["FlagSuspect"],
      );

  Map<String, dynamic> toMap() => {
        "day": day == null ? null : day,
        "from": from == null ? null : from,
        "to": to == null ? null : to,
        "FlagSuspect": flagSuspect == null ? null : flagSuspect,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
