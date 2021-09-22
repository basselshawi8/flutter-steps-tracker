
import 'dart:convert';

import 'create_user_model.dart';

class UsersListModel {
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
}

class Pagination {
  Pagination();

  factory Pagination.fromJson(String str) =>
      Pagination.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination();

  Map<String, dynamic> toMap() => {};
}
