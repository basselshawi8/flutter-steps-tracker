import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micropolis_test/features/camera/data/params/incident_param.dart';

@immutable
abstract class IncidentsEvent extends Equatable {
  const IncidentsEvent();
}

class GetIncident extends IncidentsEvent {
  final IncidentParam param;
  final CancelToken cancelToken;

  GetIncident(this.param, this.cancelToken);

  @override
  List<Object> get props => [this.param];
}
