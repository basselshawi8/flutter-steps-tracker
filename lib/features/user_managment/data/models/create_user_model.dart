import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

class CreateUserModel extends BaseModel {
  CreateUserModel({
    this.success,
    this.message,
    this.data,
  });

  final bool success;
  final String message;
  final UserData data;

  factory CreateUserModel.fromJson(String str) =>
      CreateUserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateUserModel.fromMap(Map<String, dynamic> json) => CreateUserModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : UserData.fromMap(json["data"]),
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

class UserData extends BaseModel {
  UserData({
    this.role,
    this.isLock,
    this.id,
    this.name,
    this.surname,
    this.email,
    this.password,
    this.createdAt,
    this.v,
  });

  final List<dynamic> role;
  final bool isLock;
  final String id;
  final String name;
  final String surname;
  final String email;
  final String password;
  final DateTime createdAt;
  final int v;

  factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        role: json["role"] == null
            ? null
            : List<dynamic>.from(json["role"].map((x) => x)),
        isLock: json["isLock"] == null ? null : json["isLock"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        surname: json["surname"] == null ? null : json["surname"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "role": role == null ? null : List<dynamic>.from(role.map((x) => x)),
        "isLock": isLock == null ? null : isLock,
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "surname": surname == null ? null : surname,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "__v": v == null ? null : v,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
