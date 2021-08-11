

import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

class IncidentsClassificationModel extends BaseModel {
  IncidentsClassificationModel({
    this.success,
    this.data,
  });

  final bool success;
  final List<ClassificationDatum> data;

  factory IncidentsClassificationModel.fromJson(String str) => IncidentsClassificationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IncidentsClassificationModel.fromMap(Map<String, dynamic> json) => IncidentsClassificationModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : List<ClassificationDatum>.from(json["data"].map((x) => ClassificationDatum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success == null ? null : success,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class ClassificationDatum extends BaseModel{
  ClassificationDatum({
    this.id,
    this.count,
  });

  final ClassificationId id;
  final int count;

  factory ClassificationDatum.fromJson(String str) => ClassificationDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClassificationDatum.fromMap(Map<String, dynamic> json) => ClassificationDatum(
    id: json["_id"] == null ? null : ClassificationId.fromMap(json["_id"]),
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

class ClassificationId extends BaseModel{
  ClassificationId({
    this.classification,
  });

  final String classification;

  factory ClassificationId.fromJson(String str) => ClassificationId.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClassificationId.fromMap(Map<String, dynamic> json) => ClassificationId(
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
