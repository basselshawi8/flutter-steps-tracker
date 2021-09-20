
import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

class PolygonsModel extends BaseModel{
  PolygonsModel({
    this.success,
    this.count,
    this.total,
    this.pagination,
    this.data,
  });

  final bool success;
  final int count;
  final int total;
  final Pagination pagination;
  final List<PolygonDatum> data;

  factory PolygonsModel.fromJson(String str) => PolygonsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PolygonsModel.fromMap(Map<String, dynamic> json) => PolygonsModel(
    success: json["success"] == null ? null : json["success"],
    count: json["count"] == null ? null : json["count"],
    total: json["total"] == null ? null : json["total"],
    pagination: json["pagination"] == null ? null : Pagination.fromMap(json["pagination"]),
    data: json["data"] == null ? null : List<PolygonDatum>.from(json["data"].map((x) => PolygonDatum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success == null ? null : success,
    "count": count == null ? null : count,
    "total": total == null ? null : total,
    "pagination": pagination == null ? null : pagination.toMap(),
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class PolygonDatum extends BaseModel{
  PolygonDatum({
    this.id,
    this.constraints,
    this.nationalitiesSensit,
    this.polygon,
    this.v,
  });

  final String id;
  final List<Constraint> constraints;
  final List<NationalitiesSensit> nationalitiesSensit;
  final PolygonMap polygon;
  final int v;

  factory PolygonDatum.fromJson(String str) => PolygonDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PolygonDatum.fromMap(Map<String, dynamic> json) => PolygonDatum(
    id: json["_id"] == null ? null : json["_id"],
    constraints: json["constraints"] == null ? null : List<Constraint>.from(json["constraints"].map((x) => Constraint.fromMap(x))),
    nationalitiesSensit: json["nationalitiesSensit"] == null ? null : List<NationalitiesSensit>.from(json["nationalitiesSensit"].map((x) => NationalitiesSensit.fromMap(x))),
    polygon: json["polygon"] == null ? null : PolygonMap.fromMap(json["polygon"]),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id == null ? null : id,
    "constraints": constraints == null ? null : List<dynamic>.from(constraints.map((x) => x.toMap())),
    "nationalitiesSensit": nationalitiesSensit == null ? null : List<dynamic>.from(nationalitiesSensit.map((x) => x.toMap())),
    "polygon": polygon == null ? null : polygon.toMap(),
    "__v": v == null ? null : v,
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class Constraint extends BaseModel{
  Constraint({
    this.id,
    this.day,
    this.from,
    this.to,
    this.flagSuspect,
    this.v,
  });

  final String id;
  final String day;
  final String from;
  final String to;
  final bool flagSuspect;
  final int v;

  factory Constraint.fromJson(String str) => Constraint.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Constraint.fromMap(Map<String, dynamic> json) => Constraint(
    id: json["_id"] == null ? null : json["_id"],
    day: json["day"] == null ? null : json["day"],
    from: json["from"] == null ? null : json["from"],
    to: json["to"] == null ? null : json["to"],
    flagSuspect: json["FlagSuspect"] == null ? null : json["FlagSuspect"],
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id == null ? null : id,
    "day": day == null ? null : day,
    "from": from == null ? null : from,
    "to": to == null ? null : to,
    "FlagSuspect": flagSuspect == null ? null : flagSuspect,
    "__v": v == null ? null : v,
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class NationalitiesSensit extends BaseModel{
  NationalitiesSensit({
    this.id,
    this.name,
    this.iso,
    this.v,
  });

  final String id;
  final String name;
  final String iso;
  final int v;

  factory NationalitiesSensit.fromJson(String str) => NationalitiesSensit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NationalitiesSensit.fromMap(Map<String, dynamic> json) => NationalitiesSensit(
    id: json["_id"] == null ? null : json["_id"],
    name: json["name"] == null ? null : json["name"],
    iso: json["ISO"] == null ? null : json["ISO"],
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id == null ? null : id,
    "name": name == null ? null : name,
    "ISO": iso == null ? null : iso,
    "__v": v == null ? null : v,
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class PolygonMap extends BaseModel{
  PolygonMap({
    this.id,
    this.type,
    this.coordinates,
    this.v,
  });

  final String id;
  final String type;
  final List<List<List<double>>> coordinates;
  final int v;

  factory PolygonMap.fromJson(String str) => PolygonMap.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PolygonMap.fromMap(Map<String, dynamic> json) => PolygonMap(
    id: json["_id"] == null ? null : json["_id"],
    type: json["type"] == null ? null : json["type"],
    coordinates: json["coordinates"] == null ? null : List<List<List<double>>>.from(json["coordinates"].map((x) => List<List<double>>.from(x.map((x) => List<double>.from(x.map((x) => x.toDouble())))))),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id == null ? null : id,
    "type": type == null ? null : type,
    "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
    "__v": v == null ? null : v,
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class Pagination extends BaseModel{
  Pagination();

  factory Pagination.fromJson(String str) => Pagination.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
  );

  Map<String, dynamic> toMap() => {
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
