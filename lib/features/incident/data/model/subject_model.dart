import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

class SubjectsModel extends BaseModel {
  SubjectsModel({
    this.code,
    this.message,
    this.action,
    this.data,
  });

  final int code;
  final String message;
  final String action;
  final List<SubjectModel> data;

  factory SubjectsModel.fromJson(String str) => SubjectsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubjectsModel.fromMap(Map<String, dynamic> json) => SubjectsModel(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    action: json["action"] == null ? null : json["action"],
    data: json["data"] == null ? null : List<SubjectModel>.from(json["data"].map((x) => SubjectModel.fromMap(x))),
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

class SubjectModel extends BaseModel{
  SubjectModel({
    this.idType,
    this.gender,
    this.residenceType,
    this.id,
    this.subjectId,
    this.name,
    this.surname,
    this.dateOfBirth,
    this.idNo,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.nationality,
    this.datumId,
  });

  final String idType;
  final String gender;
  final String residenceType;
  final String id;
  final String subjectId;
  final String name;
  final String surname;
  final DateTime dateOfBirth;
  final String idNo;
  final DateTime publishedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final Nationality nationality;
  final String datumId;

  factory SubjectModel.fromJson(String str) => SubjectModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubjectModel.fromMap(Map<String, dynamic> json) => SubjectModel(
    idType: json["id_type"] == null ? null : json["id_type"],
    gender: json["gender"] == null ? null : json["gender"],
    residenceType: json["residenceType"] == null ? null : json["residenceType"],
    id: json["_id"] == null ? null : json["_id"],
    subjectId: json["subject_id"] == null ? null : json["subject_id"],
    name: json["name"] == null ? null : json["name"],
    surname: json["surname"] == null ? null : json["surname"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    idNo: json["id_no"] == null ? null : json["id_no"],
    publishedAt: json["published_at"] == null ? null : DateTime.parse(json["published_at"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"] == null ? null : json["__v"],
    nationality: json["nationality"] == null ? null : Nationality.fromMap(json["nationality"]),
    datumId: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toMap() => {
    "id_type": idType == null ? null : idType,
    "gender": gender == null ? null : gender,
    "residenceType": residenceType == null ? null : residenceType,
    "_id": id == null ? null : id,
    "subject_id": subjectId == null ? null : subjectId,
    "name": name == null ? null : name,
    "surname": surname == null ? null : surname,
    "dateOfBirth": dateOfBirth == null ? null : "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "id_no": idNo == null ? null : idNo,
    "published_at": publishedAt == null ? null : publishedAt.toIso8601String(),
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "__v": v == null ? null : v,
    "nationality": nationality == null ? null : nationality.toMap(),
    "id": datumId == null ? null : datumId,
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class Nationality extends BaseModel{
  Nationality({
    this.id,
    this.country,
    this.nationality,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.nationalityId,
  });

  final String id;
  final String country;
  final String nationality;
  final DateTime publishedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String nationalityId;

  factory Nationality.fromJson(String str) => Nationality.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Nationality.fromMap(Map<String, dynamic> json) => Nationality(
    id: json["_id"] == null ? null : json["_id"],
    country: json["country"] == null ? null : json["country"],
    nationality: json["nationality"] == null ? null : json["nationality"],
    publishedAt: json["published_at"] == null ? null : DateTime.parse(json["published_at"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"] == null ? null : json["__v"],
    nationalityId: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id == null ? null : id,
    "country": country == null ? null : country,
    "nationality": nationality == null ? null : nationality,
    "published_at": publishedAt == null ? null : publishedAt.toIso8601String(),
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "__v": v == null ? null : v,
    "id": nationalityId == null ? null : nationalityId,
  };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
