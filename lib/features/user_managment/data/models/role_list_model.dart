
// To parse this JSON data, do
//
//     final roleListModel = roleListModelFromMap(jsonString);

import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';

class RoleListModel extends BaseModel{
  RoleListModel({
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
  final List<RoleData> data;

  factory RoleListModel.fromJson(String str) => RoleListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoleListModel.fromMap(Map<String, dynamic> json) => RoleListModel(
    success: json["success"] == null ? null : json["success"],
    count: json["count"] == null ? null : json["count"],
    total: json["total"] == null ? null : json["total"],
    pagination: json["pagination"] == null ? null : Pagination.fromMap(json["pagination"]),
    data: json["data"] == null ? null : List<RoleData>.from(json["data"].map((x) => RoleData.fromMap(x))),
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

class RoleData extends BaseModel{
  RoleData({
    this.isLock,
    this.pages,
    this.id,
    this.name,
    this.v,
  });

  final bool isLock;
  final List<dynamic> pages;
  final String id;
  final String name;
  final int v;

  factory RoleData.fromJson(String str) => RoleData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoleData.fromMap(Map<String, dynamic> json) => RoleData(
    isLock: json["isLock"] == null ? null : json["isLock"],
    pages: json["pages"] == null ? null : List<dynamic>.from(json["pages"].map((x) => x)),
    id: json["_id"] == null ? null : json["_id"],
    name: json["name"] == null ? null : json["name"],
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "isLock": isLock == null ? null : isLock,
    "pages": pages == null ? null : List<dynamic>.from(pages.map((x) => x)),
    "_id": id == null ? null : id,
    "name": name == null ? null : name,
    "__v": v == null ? null : v,
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

