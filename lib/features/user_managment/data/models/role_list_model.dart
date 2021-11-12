
// To parse this JSON data, do
//
//     final roleListModel = roleListModelFromMap(jsonString);

import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

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

class Pagination extends BaseModel {
  Pagination({
    this.next,
  });

  final Next next;

  factory Pagination.fromJson(String str) =>
      Pagination.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
    next: json["next"] == null ? null : Next.fromMap(json["next"]),
  );

  Map<String, dynamic> toMap() => {
    "next": next == null ? null : next.toMap(),
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class Next extends BaseModel {
  Next({
    this.page,
    this.limit,
  });

  final int page;
  final int limit;

  factory Next.fromJson(String str) => Next.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Next.fromMap(Map<String, dynamic> json) => Next(
    page: json["page"] == null ? null : json["page"],
    limit: json["limit"] == null ? null : json["limit"],
  );

  Map<String, dynamic> toMap() => {
    "page": page == null ? null : page,
    "limit": limit == null ? null : limit,
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}