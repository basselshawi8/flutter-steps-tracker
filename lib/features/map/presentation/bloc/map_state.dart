import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/features/map/data/models/authority_area_model.dart';
import 'package:micropolis_test/features/map/data/models/create_polygon_model.dart';
import 'package:micropolis_test/features/map/data/models/police_department_model.dart';
import 'package:micropolis_test/features/map/data/models/polygons_model.dart';
import 'package:micropolis_test/features/map/data/models/region_model.dart';
import 'package:micropolis_test/features/map/data/models/region_type_model.dart';
import 'package:micropolis_test/features/map/data/models/sensitive_location_model.dart';

@immutable
abstract class MapState extends Equatable {
  const MapState();
}

class InitialMapState extends MapState {
  const InitialMapState();

  @override
  List<Object> get props => [];
}

/// create Sensitive Location
class CreateSensitiveLocationWaitingState extends MapState {
  const CreateSensitiveLocationWaitingState();

  @override
  List<Object> get props => [];
}

class CreateSensitiveLocationSuccessState extends MapState {
  final SensitiveLocationModel sensitiveLocationModel;

  const CreateSensitiveLocationSuccessState(this.sensitiveLocationModel);

  @override
  List<Object> get props => [sensitiveLocationModel];
}

class CreateSensitiveLocationFailureState extends MapState {
  final BaseError error;
  final VoidCallback callback;

  const CreateSensitiveLocationFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}

/// get polygons
class GetPolygonsWaitingState extends MapState {
  const GetPolygonsWaitingState();

  @override
  List<Object> get props => [];
}

class GetPolygonsSuccessState extends MapState {
  final PolygonsModel polygonModel;

  const GetPolygonsSuccessState(this.polygonModel);

  @override
  List<Object> get props => [polygonModel];
}

class GetPolygonsFailureState extends MapState {
  final BaseError error;
  final VoidCallback callback;

  const GetPolygonsFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}

///  get Regions
class GetRegionsWaitingState extends MapState {
  const GetRegionsWaitingState();

  @override
  List<Object> get props => [];
}

class GetRegionsSuccessState extends MapState {
  final RegionModel regionModel;

  const GetRegionsSuccessState(this.regionModel);

  @override
  List<Object> get props => [regionModel];
}

class GetRegionsFailureState extends MapState {
  final BaseError error;
  final VoidCallback callback;

  const GetRegionsFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}

///  get RegionTypes
class GetRegionTypesWaitingState extends MapState {
  const GetRegionTypesWaitingState();

  @override
  List<Object> get props => [];
}

class GetRegionTypesSuccessState extends MapState {
  final RegionTypeModel regionTypeModel;

  const GetRegionTypesSuccessState(this.regionTypeModel);

  @override
  List<Object> get props => [regionTypeModel];
}

class GetRegionTypesFailureState extends MapState {
  final BaseError error;
  final VoidCallback callback;

  const GetRegionTypesFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}

///  get Police Departments
class GetPoliceDepartmentsWaitingState extends MapState {
  const GetPoliceDepartmentsWaitingState();

  @override
  List<Object> get props => [];
}

class GetPoliceDepartmentsSuccessState extends MapState {
  final PoliceDepartmentModel policeDepartmentModel;

  const GetPoliceDepartmentsSuccessState(this.policeDepartmentModel);

  @override
  List<Object> get props => [policeDepartmentModel];
}

class GetPoliceDepartmentsFailureState extends MapState {
  final BaseError error;
  final VoidCallback callback;

  const GetPoliceDepartmentsFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}

///  get Authority Areas
class GetAuthorityAreasWaitingState extends MapState {
  const GetAuthorityAreasWaitingState();

  @override
  List<Object> get props => [];
}

class GetAuthorityAreasSuccessState extends MapState {
  final AuthorityAreaModel authorityAreaModel;

  const GetAuthorityAreasSuccessState(this.authorityAreaModel);

  @override
  List<Object> get props => [authorityAreaModel];
}

class GetAuthorityAreasFailureState extends MapState {
  final BaseError error;
  final VoidCallback callback;

  const GetAuthorityAreasFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}


///  create Authority Area
class CreateAuthorityAreaWaitingState extends MapState {
  const CreateAuthorityAreaWaitingState();

  @override
  List<Object> get props => [];
}

class CreateAuthorityAreaSuccessState extends MapState {
  final AuthorityAreaModel authorityAreaModel;

  const CreateAuthorityAreaSuccessState(this.authorityAreaModel);

  @override
  List<Object> get props => [authorityAreaModel];
}

class CreateAuthorityAreaFailureState extends MapState {
  final BaseError error;
  final VoidCallback callback;

  const CreateAuthorityAreaFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}


///  get Sensitive Locations
class GetSensitiveLocationsWaitingState extends MapState {
  const GetSensitiveLocationsWaitingState();

  @override
  List<Object> get props => [];
}

class GetSensitiveLocationsSuccessState extends MapState {
  final GetSensitiveLocationModel sensitiveLocationModel;

  const GetSensitiveLocationsSuccessState(this.sensitiveLocationModel);

  @override
  List<Object> get props => [sensitiveLocationModel];
}

class GetSensitiveLocationsFailureState extends MapState {
  final BaseError error;
  final VoidCallback callback;

  const GetSensitiveLocationsFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}