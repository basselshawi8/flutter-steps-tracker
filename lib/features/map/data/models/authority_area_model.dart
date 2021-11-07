import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';
import 'package:micropolis_test/features/map/data/models/police_department_model.dart';

class AuthorityAreaModel extends BaseModel {
  AuthorityAreaModel({
    this.code,
    this.message,
    this.action,
    this.data,
  });

  final int code;
  final String message;
  final String action;
  final List<AuthorityAreaData> data;

  factory AuthorityAreaModel.fromJson(String str) =>
      AuthorityAreaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthorityAreaModel.fromMap(Map<String, dynamic> json) =>
      AuthorityAreaModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        action: json["action"] == null ? null : json["action"],
        data: json["data"] == null
            ? null
            : json["data"] is List
                ? List<AuthorityAreaData>.from(
                    json["data"].map((x) => AuthorityAreaData.fromMap(x)))
                : [AuthorityAreaData.fromMap(json["data"])],
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

class AuthorityAreaData extends BaseModel {
  AuthorityAreaData({
    this.id,
    this.title,
    this.polygon,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.policeDept,
    this.datumId,
  });

  final String id;
  final String title;
  final PolygonData polygon;
  final DateTime publishedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final PoliceDepartmentData policeDept;
  final String datumId;

  factory AuthorityAreaData.fromJson(String str) =>
      AuthorityAreaData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthorityAreaData.fromMap(Map<String, dynamic> json) =>
      AuthorityAreaData(
        id: json["_id"] == null ? null : json["_id"],
        title: json["title"] == null ? null : json["title"],
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
        policeDept: json["police_dept"] == null
            ? null
            : PoliceDepartmentData.fromMap(json["police_dept"]),
        datumId: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "title": title == null ? null : title,
        "polygon": polygon == null ? null : polygon.toMap(),
        "published_at":
            publishedAt == null ? null : publishedAt.toIso8601String(),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
        "police_dept": policeDept.toMap(),
        "id": datumId == null ? null : datumId,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class PolygonData extends BaseModel {
  PolygonData({
    this.type,
    this.coordinates,
  });

  final String type;
  final List<List<List<num>>> coordinates;

  factory PolygonData.fromJson(String str) =>
      PolygonData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PolygonData.fromMap(Map<String, dynamic> json) => PolygonData(
        type: json["type"] == null ? null : json["type"],
        coordinates: json["coordinates"] == null
            ? null
            : List<List<List<num>>>.from(json["coordinates"].map((x) =>
                List<List<num>>.from(
                    x.map((x) => List<num>.from(x.map((x) => x)))))),
      );

  Map<String, dynamic> toMap() => {
        "type": type == null ? null : type,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(
                x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
