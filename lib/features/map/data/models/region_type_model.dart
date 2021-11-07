import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

class RegionTypeModel extends BaseModel{
  RegionTypeModel({
    this.code,
    this.message,
    this.action,
    this.data,
  });

  final int code;
  final String message;
  final String action;
  final List<RegionTypeData> data;

  factory RegionTypeModel.fromJson(String str) =>
      RegionTypeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegionTypeModel.fromMap(Map<String, dynamic> json) => RegionTypeModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        action: json["action"] == null ? null : json["action"],
        data: json["data"] == null
            ? null
            : List<RegionTypeData>.from(
                json["data"].map((x) => RegionTypeData.fromMap(x))),
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

class RegionTypeData extends BaseModel{
  RegionTypeData({
    this.id,
    this.name,
    this.code,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.datumId,
  });

  final String id;
  final String name;
  final String code;
  final DateTime publishedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String datumId;

  factory RegionTypeData.fromJson(String str) =>
      RegionTypeData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegionTypeData.fromMap(Map<String, dynamic> json) => RegionTypeData(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        code: json["code"] == null ? null : json["code"],
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
        datumId: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "code": code == null ? null : code,
        "published_at":
            publishedAt == null ? null : publishedAt.toIso8601String(),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
        "id": datumId == null ? null : datumId,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
