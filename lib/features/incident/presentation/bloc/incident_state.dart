import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_classification_model.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/features/incident/data/model/subject_model.dart';

@immutable
abstract class IncidentsState extends Equatable {
  const IncidentsState();
}

class InitialIncidentsState extends IncidentsState {
  const InitialIncidentsState();

  @override
  List<Object> get props => [];
}

/// GetAddress
class GetIncidentsWaitingState extends IncidentsState {
  const GetIncidentsWaitingState();

  @override
  List<Object> get props => [];
}

class GetIncidentsSuccessState extends IncidentsState {
  final IncidentsModel incidents;

  const GetIncidentsSuccessState(this.incidents);

  @override
  List<Object> get props => [incidents];
}

class GetSingleIncidentSuccessState extends IncidentsState {
  final IncidentModel incident;

  const GetSingleIncidentSuccessState(this.incident);

  @override
  List<Object> get props => [incident];
}

class DeleteIncidentSuccessState extends IncidentsState {
  final IncidentModel incident;

  const DeleteIncidentSuccessState(this.incident);

  @override
  List<Object> get props => [incident];
}

class UpgradeIncidentSuccessState extends IncidentsState {
  final IncidentModel incident;

  const UpgradeIncidentSuccessState(this.incident);

  @override
  List<Object> get props => [incident];
}

class GetSubjectsSuccessState extends IncidentsState {
  final SubjectsModel subjects;

  const GetSubjectsSuccessState(this.subjects);

  @override
  List<Object> get props => [subjects];
}

class GetIncidentsClassificationSuccessState extends IncidentsState {
  final IncidentsClassificationModel classifications;

  const GetIncidentsClassificationSuccessState(this.classifications);

  @override
  List<Object> get props => [classifications];
}

class GetIncidentFailureState extends IncidentsState {
  final BaseError error;
  final VoidCallback callback;

  const GetIncidentFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}
