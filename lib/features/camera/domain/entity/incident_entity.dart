import 'package:micropolis_test/core/entities/base_entity.dart';

class IncidentEntity extends BaseEntity {
  IncidentEntity({
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

  final IdEntity id;
  final String suspectId;
  final String incidentDesc;
  final String imageCap;
  final String imageMatch;
  final String classification;
  final String vehicleId;
  final DateRaiseEntity dateRaise;
  final String latitude;
  final String longitude;
  final String behavioralClass;
  final String incidentType;

  @override
  // TODO: implement props
  List<Object> get props => [
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
        this.incidentType
      ];
}

class DateRaiseEntity extends BaseEntity {
  DateRaiseEntity({
    this.date,
  });

  final int date;

  @override
  // TODO: implement props
  List<Object> get props => [this.date];
}

class IdEntity extends BaseEntity {
  IdEntity({
    this.oid,
  });

  final String oid;

  @override
  // TODO: implement props
  List<Object> get props => [this.oid];
}
