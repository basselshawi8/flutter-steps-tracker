
import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';

import 'create_user_model.dart';

class UsersListModel extends BaseModel{
  UsersListModel({
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
  final List<UserData> data;

  factory UsersListModel.fromJson(String str) =>
      UsersListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsersListModel.fromMap(Map<String, dynamic> json) => UsersListModel(
        success: json["success"] == null ? null : json["success"],
        count: json["count"] == null ? null : json["count"],
        total: json["total"] == null ? null : json["total"],
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromMap(json["pagination"]),
        data: json["data"] == null
            ? null
            : List<UserData>.from(json["data"].map((x) => UserData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "count": count == null ? null : count,
        "total": total == null ? null : total,
        "pagination": pagination == null ? null : pagination.toMap(),
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