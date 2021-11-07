import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/map/data/params/add_authority_param.dart';
import 'package:micropolis_test/features/map/data/params/add_polygon_param.dart';

@immutable
abstract class MapEvent extends Equatable {
  const MapEvent();
}

class CreateSensitiveLocation extends MapEvent {
  final AddSensitiveLocationParam param;

  CreateSensitiveLocation(this.param);

  @override
  List<Object> get props => [this.param];
}

class GetPolygons extends MapEvent {
  final NoParams param;

  GetPolygons(this.param);

  @override
  List<Object> get props => [this.param];
}

class GetRegionTypes extends MapEvent {
  final NoParams param;

  GetRegionTypes(this.param);

  @override
  List<Object> get props => [this.param];
}

class GetRegions extends MapEvent {
  final NoParams param;

  GetRegions(this.param);

  @override
  List<Object> get props => [this.param];
}

class GetPoliceDepartments extends MapEvent {
  final NoParams param;

  GetPoliceDepartments(this.param);

  @override
  List<Object> get props => [this.param];
}

class GetAuthorityAreas extends MapEvent {
  final NoParams param;

  GetAuthorityAreas(this.param);

  @override
  List<Object> get props => [this.param];
}

class CreateAuthorityArea extends MapEvent {
  final AddAuthorityParam param;

  CreateAuthorityArea(this.param);

  @override
  List<Object> get props => [this.param];
}

class GetSensitiveLocations extends MapEvent {
  final NoParams param;

  GetSensitiveLocations(this.param);

  @override
  List<Object> get props => [this.param];
}
