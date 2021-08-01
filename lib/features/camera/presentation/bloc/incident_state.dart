import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micropolis_test/features/camera/domain/entity/incident_entity.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/menu_entity.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/restaurant_entity.dart';
import 'package:micropolis_test/core/errors/base_error.dart';

@immutable
abstract class IncidentState extends Equatable {
  const IncidentState();
}

class InitialIncidentState extends IncidentState {
  const InitialIncidentState();

  @override
  List<Object> get props => [];
}

/// GetAddress
class GetIncidentWaitingState extends IncidentState {
  const GetIncidentWaitingState();

  @override
  List<Object> get props => [];
}

class GetIncidentSuccessState extends IncidentState {
  final IncidentEntity incident;

  const GetIncidentSuccessState(this.incident);

  @override
  List<Object> get props => [incident];
}

class GetIncidentFailureState extends IncidentState {
  final BaseError error;
  final VoidCallback callback;

  const GetIncidentFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}
