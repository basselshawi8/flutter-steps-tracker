import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micropolis_test/features/incident/data/params/incidents_param.dart';

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
