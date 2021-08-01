// To parse this JSON data, do
//
//     final menuSectionModel = menuSectionModelFromMap(jsonString);

import 'dart:convert';

import 'package:micropolis_test/core/models/BaseModel.dart';
import 'package:micropolis_test/features/camera/domain/entity/incident_entity.dart';

class IncidentModel extends BaseModel<IncidentEntity> {
  IncidentModel({
    this.id,
    this.suspectId,
    this.incidentDesc,
    this.imageCap,
    this.imageMatch,
    this.classification,
    this.vehicleId,
    this.dateRaise,
    this.latitude,
    this.longitude,
    this.behavioralClass,
    this.incidentType,
  });

  final Id id;
  final String suspectId;
  final String incidentDesc;
  final String imageCap;
  final String imageMatch;
  final String classification;
  final String vehicleId;
  final DateRaise dateRaise;
  final String latitude;
  final String longitude;
  final String behavioralClass;
  final String incidentType;

  factory IncidentModel.fromJson(String str) =>
      IncidentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IncidentModel.fromMap(Map<String, dynamic> json) => IncidentModel(
        id: json["_id"] == null ? null : Id.fromMap(json["_id"]),
        suspectId: json["suspectID"] == null ? null : json["suspectID"],
        incidentDesc:
            json["incidentDesc"] == null ? null : json["incidentDesc"],
        imageCap: json["imageCap"] == null ? null : json["imageCap"],
        imageMatch: json["imageMatch"] == null ? null : json["imageMatch"],
        classification:
            json["classification"] == null ? null : json["classification"],
        vehicleId: json["vehicle_id"] == null ? null : json["vehicle_id"],
        dateRaise: json["dateRaise"] == null
            ? null
            : DateRaise.fromMap(json["dateRaise"]),
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        behavioralClass:
            json["behavioralClass"] == null ? null : json["behavioralClass"],
        incidentType:
            json["incidentType"] == null ? null : json["incidentType"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id.toMap(),
        "suspectID": suspectId == null ? null : suspectId,
        "incidentDesc": incidentDesc == null ? null : incidentDesc,
        "imageCap": imageCap == null ? null : imageCap,
        "imageMatch": imageMatch == null ? null : imageMatch,
        "classification": classification == null ? null : classification,
        "vehicle_id": vehicleId == null ? null : vehicleId,
        "dateRaise": dateRaise == null ? null : dateRaise.toMap(),
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "behavioralClass": behavioralClass == null ? null : behavioralClass,
        "incidentType": incidentType == null ? null : incidentType,
      };

  @override
  IncidentEntity toEntity() {
    return IncidentEntity(
        id: this.id?.toEntity(),
        suspectId: this.suspectId,
        incidentDesc: this.incidentDesc,
        imageCap: this.imageCap,
        imageMatch: this.imageMatch,
        classification: this.classification,
        vehicleId: this.vehicleId,
        dateRaise: this.dateRaise?.toEntity(),
        latitude: this.latitude,
        longitude: this.longitude,
        behavioralClass: this.behavioralClass,
        incidentType: this.incidentType);
  }
}

class DateRaise extends BaseModel<DateRaiseEntity> {
  DateRaise({
    this.date,
  });

  final int date;

  factory DateRaise.fromJson(String str) => DateRaise.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DateRaise.fromMap(Map<String, dynamic> json) => DateRaise(
        date: json["\u0024date"] == null ? null : json["\u0024date"],
      );

  Map<String, dynamic> toMap() => {
        "\u0024date": date == null ? null : date,
      };

  @override
  DateRaiseEntity toEntity() {
    return DateRaiseEntity(date: this.date);
  }
}

class Id extends BaseModel<IdEntity> {
  Id({
    this.oid,
  });

  final String oid;

  factory Id.fromJson(String str) => Id.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Id.fromMap(Map<String, dynamic> json) => Id(
        oid: json["\u0024oid"] == null ? null : json["\u0024oid"],
      );

  Map<String, dynamic> toMap() => {
        "\u0024oid": oid == null ? null : oid,
      };

  @override
  IdEntity toEntity() {
    return IdEntity(oid: this.oid);
  }
}
