import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

class CreatePolygonModel extends BaseModel {
  CreatePolygonModel({
    this.success,
    this.message,
    this.data,
  });

  final bool success;
  final String message;
  final PolygonData data;

  factory CreatePolygonModel.fromJson(String str) =>
      CreatePolygonModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreatePolygonModel.fromMap(Map<String, dynamic> json) =>
      CreatePolygonModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : PolygonData.fromMap(json["data"]),
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

class PolygonData extends BaseModel{
  PolygonData({
    this.constraints,
    this.nationalitiesSensit,
    this.polygon,
    this.id,
    this.v,
  });

  final List<String> constraints;
  final List<dynamic> nationalitiesSensit;
  final String polygon;
  final String id;
  final int v;

  factory PolygonData.fromJson(String str) =>
      PolygonData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PolygonData.fromMap(Map<String, dynamic> json) => PolygonData(
        constraints: json["constraints"] == null
            ? null
            : List<String>.from(json["constraints"].map((x) => x)),
        nationalitiesSensit: json["nationalitiesSensit"] == null
            ? null
            : List<dynamic>.from(json["nationalitiesSensit"].map((x) => x)),
        polygon: json["polygon"] == null ? null : json["polygon"],
        id: json["_id"] == null ? null : json["_id"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "constraints": constraints == null
            ? null
            : List<dynamic>.from(constraints.map((x) => x)),
        "nationalitiesSensit": nationalitiesSensit == null
            ? null
            : List<dynamic>.from(nationalitiesSensit.map((x) => x)),
        "polygon": polygon == null ? null : polygon,
        "_id": id == null ? null : id,
        "__v": v == null ? null : v,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
