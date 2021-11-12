

import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

class IncidentsClassificationModel extends BaseModel {
  IncidentsClassificationModel({
    this.code,
    this.message,
    this.action,
    this.data,
  });

  final int code;
  final String message;
  final String action;
  final List<ClassificationDatum> data;

  factory IncidentsClassificationModel.fromJson(String str) => IncidentsClassificationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IncidentsClassificationModel.fromMap(Map<String, dynamic> json) => IncidentsClassificationModel(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    action: json["action"] == null ? null : json["action"],
    data: json["data"] == null ? null : List<ClassificationDatum>.from(json["data"].map((x) => ClassificationDatum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "action": action == null ? null : action,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class ClassificationDatum extends BaseModel {
  ClassificationDatum({
    this.id,
    this.count,
  });

  final Id id;
  final int count;

  factory ClassificationDatum.fromJson(String str) => ClassificationDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClassificationDatum.fromMap(Map<String, dynamic> json) => ClassificationDatum(
    id: json["_id"] == null ? null : Id.fromMap(json["_id"]),
    count: json["count"] == null ? null : json["count"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id == null ? null : id.toMap(),
    "count": count == null ? null : count,
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class Id extends BaseModel{
  Id({
    this.classification,
  });

  final String classification;

  factory Id.fromJson(String str) => Id.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Id.fromMap(Map<String, dynamic> json) => Id(
    classification: json["classification"] == null ? null : json["classification"],
  );

  Map<String, dynamic> toMap() => {
    "classification": classification == null ? null : classification,
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
