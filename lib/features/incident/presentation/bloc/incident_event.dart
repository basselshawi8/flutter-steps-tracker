import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/incident/data/params/incidents_param.dart';
import 'package:micropolis_test/features/incident/data/params/single_incident_param.dart';
import 'package:micropolis_test/features/incident/data/params/subject_param.dart';
import 'package:micropolis_test/features/incident/data/params/update_incident_param.dart';

@immutable
abstract class IncidentsEvent extends Equatable {
  const IncidentsEvent();
}

class GetIncidents extends IncidentsEvent {
  final IncidentsParam param;

  GetIncidents(this.param);

  @override
  List<Object> get props => [this.param];
}

class GetSingleIncident extends IncidentsEvent {
  final SingleIncidentParam param;

  GetSingleIncident(this.param);

  @override
  List<Object> get props => [this.param];
}

class DeleteIncident extends IncidentsEvent {
  final SingleIncidentParam param;

  DeleteIncident(this.param);

  @override
  List<Object> get props => [this.param];
}


class UpgradeIncident extends IncidentsEvent {
  final UpdateIncidentParam param;

  UpgradeIncident(this.param);

  @override
  List<Object> get props => [this.param];
}

class GetIncidentClassification extends IncidentsEvent {
  final NoParams param;

  GetIncidentClassification(this.param);

  @override
  List<Object> get props => [this.param];
}

class GetSubjects extends IncidentsEvent {
  final SubjectsParam param;

  GetSubjects(this.param);

  @override
  List<Object> get props => [this.param];
}
