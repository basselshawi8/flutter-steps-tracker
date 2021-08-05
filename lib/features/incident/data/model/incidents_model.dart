import 'dart:convert';

import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';

class IncidentsModel extends BaseModel {
  IncidentsModel({
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
  final List<IncidentsDatum> data;

  factory IncidentsModel.fromJson(String str) =>
      IncidentsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IncidentsModel.fromMap(Map<String, dynamic> json) => IncidentsModel(
        success: json.containsKey("success") == false
            ? null
            : json["success"] == null
                ? null
                : json["success"],
        count: json.containsKey("count") == false
            ? null
            : json["count"] == null
                ? null
                : json["count"],
        total: json.containsKey("total") == false
            ? null
            : json["total"] == null
                ? null
                : json["total"],
        pagination: json.containsKey("pagination") == false
            ? null
            : json["pagination"] == null
                ? null
                : Pagination.fromMap(json["pagination"]),
        data: json.containsKey("data") == false
            ? null
            : json["data"] == null
                ? null
                : List<IncidentsDatum>.from(json["data"].map((x) => IncidentsDatum.fromMap(x))),
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

class IncidentsDatum extends BaseModel{
  IncidentsDatum({
    this.suspects,
    this.id,
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
    this.v,
  });

  final List<int> suspects;
  final String id;
  final String incidentDesc;
  final String imageCap;
  final String imageMatch;
  final BehavioralClass classification;
  final String vehicleId;
  final String dateRaise;
  final String latitude;
  final String longitude;
  final BehavioralClass behavioralClass;
  final String incidentType;
  final int v;

  factory IncidentsDatum.fromJson(String str) => IncidentsDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IncidentsDatum.fromMap(Map<String, dynamic> json) => IncidentsDatum(
        suspects: json.containsKey("suspects") == false
            ? null
            : json["suspects"] == null
                ? null
                : List<int>.from(json["suspects"].map((x) => x)),
        id: json.containsKey("_id") == false
            ? null
            : json["_id"] == null
                ? null
                : json["_id"],
        incidentDesc: json.containsKey("incidentDesc") == false
            ? null
            : json["incidentDesc"] == null
                ? null
                : json["incidentDesc"],
        imageCap: json.containsKey("imageCap") == false
            ? null
            : json["imageCap"] == null
                ? null
                : json["imageCap"],
        imageMatch: json.containsKey("imageMatch") == false
            ? null
            : json["imageMatch"] == null
                ? null
                : json["imageMatch"],
        classification: json.containsKey("classification") == false
            ? null
            : json["classification"] == null
                ? null
                : behavioralClassValues.map[json["classification"]],
        vehicleId: json.containsKey("vehicle_id") == false
            ? null
            : json["vehicle_id"] == null
                ? null
                : json["vehicle_id"],
        dateRaise: json.containsKey("dateRaise") == false
            ? null
            : json["dateRaise"] == null
                ? null
                : json["dateRaise"],
        latitude: json.containsKey("latitude") == false
            ? null
            : json["latitude"] == null
                ? null
                : json["latitude"],
        longitude: json.containsKey("longitude") == false
            ? null
            : json["longitude"] == null
                ? null
                : json["longitude"],
        behavioralClass: json.containsKey("behaviorClass") == false
            ? null
            : json["behavioralClass"] == null
                ? null
                : behavioralClassValues.map[json["behavioralClass"]],
        incidentType: json.containsKey("incidentType") == false
            ? null
            : json["incidentType"] == null
                ? null
                : json["incidentType"],
        v: json.containsKey("__v") == false
            ? null
            : json["__v"] == null
                ? null
                : json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "suspects": suspects == null
            ? null
            : List<dynamic>.from(suspects.map((x) => x)),
        "_id": id == null ? null : id,
        "incidentDesc": incidentDesc == null ? null : incidentDesc,
        "imageCap": imageCap == null ? null : imageCap,
        "imageMatch": imageMatch == null ? null : imageMatch,
        "classification": classification == null
            ? null
            : behavioralClassValues.reverse[classification],
        "vehicle_id": vehicleId == null ? null : vehicleId,
        "dateRaise": dateRaise == null ? null : dateRaise,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "behavioralClass": behavioralClass == null
            ? null
            : behavioralClassValues.reverse[behavioralClass],
        "incidentType": incidentType == null ? null : incidentType,
        "__v": v == null ? null : v,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

enum BehavioralClass { ALPHA, DELTA, GAMMA, BETA }

final behavioralClassValues = EnumValues({
  "alpha": BehavioralClass.ALPHA,
  "beta": BehavioralClass.BETA,
  "delta": BehavioralClass.DELTA,
  "gamma": BehavioralClass.GAMMA
});

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

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
