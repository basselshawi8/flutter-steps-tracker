import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';
import 'package:micropolis_test/core/errors/base_error.dart';

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

class GetIncidentFailureState extends IncidentsState {
  final BaseError error;
  final VoidCallback callback;

  const GetIncidentFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}
