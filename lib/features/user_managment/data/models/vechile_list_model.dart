
import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';
import 'package:micropolis_test/features/map/data/models/polygons_model.dart';

class VehicleListModel extends BaseModel{
  VehicleListModel({
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
  final List<VehicleData> data;

  factory VehicleListModel.fromJson(String str) => VehicleListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VehicleListModel.fromMap(Map<String, dynamic> json) => VehicleListModel(
    success: json["success"] == null ? null : json["success"],
    count: json["count"] == null ? null : json["count"],
    total: json["total"] == null ? null : json["total"],
    pagination: json["pagination"] == null ? null : Pagination.fromMap(json["pagination"]),
    data: json["data"] == null ? null : List<VehicleData>.from(json["data"].map((x) => VehicleData.fromMap(x))),
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

class VehicleData extends BaseModel {
  VehicleData({
    this.isActive,
    this.id,
    this.name,
    this.vehicleId,
    this.vehicleCode,
    this.v,
  });

  final bool isActive;
  final String id;
  final String name;
  final String vehicleId;
  final String vehicleCode;
  final int v;

  factory VehicleData.fromJson(String str) => VehicleData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VehicleData.fromMap(Map<String, dynamic> json) => VehicleData(
    isActive: json["is_Active"] == null ? null : json["is_Active"],
    id: json["_id"] == null ? null : json["_id"],
    name: json["name"] == null ? null : json["name"],
    vehicleId: json["vehicle_id"] == null ? null : json["vehicle_id"],
    vehicleCode: json["vehicle_code"] == null ? null : json["vehicle_code"],
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "is_Active": isActive == null ? null : isActive,
    "_id": id == null ? null : id,
    "name": name == null ? null : name,
    "vehicle_id": vehicleId == null ? null : vehicleId,
    "vehicle_code": vehicleCode == null ? null : vehicleCode,
    "__v": v == null ? null : v,
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
