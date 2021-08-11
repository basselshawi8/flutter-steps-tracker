import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

class SubjectsModel extends BaseModel {
  SubjectsModel({
    this.success,
    this.count,
    this.data,
  });

  final bool success;
  final int count;
  final List<SubjectModel> data;

  factory SubjectsModel.fromJson(String str) =>
      SubjectsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubjectsModel.fromMap(Map<String, dynamic> json) => SubjectsModel(
        success: json["success"] == null ? null : json["success"],
        count: json["count"] == null ? null : json["count"],
        data: json["data"] == null
            ? null
            : List<SubjectModel>.from(
                json["data"].map((x) => SubjectModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "count": count == null ? null : count,
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

class SubjectModel extends BaseModel {
  SubjectModel({
    this.criminalRecords,
    this.id,
    this.subjectId,
    this.name,
    this.surname,
    this.nationality,
    this.gender,
    this.dateOfBirth,
    this.idType,
    this.idNo,
    this.residenceStatus,
    this.v,
  });

  final List<dynamic> criminalRecords;
  final String id;
  final int subjectId;
  final String name;
  final String surname;
  final String nationality;
  final String gender;
  final DateTime dateOfBirth;
  final String idType;
  final String idNo;
  final String residenceStatus;
  final int v;

  factory SubjectModel.fromJson(String str) =>
      SubjectModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubjectModel.fromMap(Map<String, dynamic> json) => SubjectModel(
        criminalRecords: json["criminalRecords"] == null
            ? null
            : List<dynamic>.from(json["criminalRecords"].map((x) => x)),
        id: json["_id"] == null ? null : json["_id"],
        subjectId: json["subject_id"] == null ? null : json["subject_id"],
        name: json["name"] == null ? null : json["name"],
        surname: json["surname"] == null ? null : json["surname"],
        nationality: json["nationality"] == null ? null : json["nationality"],
        gender: json["gender"] == null ? null : json["gender"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        idType: json["id_type"] == null ? null : json["id_type"],
        idNo: json["id_no"] == null ? null : json["id_no"],
        residenceStatus:
            json["residenceStatus"] == null ? null : json["residenceStatus"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "criminalRecords": criminalRecords == null
            ? null
            : List<dynamic>.from(criminalRecords.map((x) => x)),
        "_id": id == null ? null : id,
        "subject_id": subjectId == null ? null : subjectId,
        "name": name == null ? null : name,
        "surname": surname == null ? null : surname,
        "nationality": nationality == null ? null : nationality,
        "gender": gender == null ? null : gender,
        "dateOfBirth":
            dateOfBirth == null ? null : dateOfBirth.toIso8601String(),
        "id_type": idType == null ? null : idType,
        "id_no": idNo == null ? null : idNo,
        "residenceStatus": residenceStatus == null ? null : residenceStatus,
        "__v": v == null ? null : v,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
