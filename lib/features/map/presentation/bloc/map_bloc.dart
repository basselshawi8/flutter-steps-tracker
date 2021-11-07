import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/features/map/data/datasource/polygon_datasource.dart';
import 'package:micropolis_test/features/map/data/models/authority_area_model.dart';
import 'package:micropolis_test/features/map/data/models/create_polygon_model.dart';
import 'package:micropolis_test/features/map/data/models/police_department_model.dart';
import 'package:micropolis_test/features/map/data/models/polygons_model.dart';
import 'package:micropolis_test/features/map/data/models/region_model.dart';
import 'package:micropolis_test/features/map/data/models/region_type_model.dart';
import 'package:micropolis_test/features/map/data/models/sensitive_location_model.dart';

import './bloc.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(InitialMapState());

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is CreateSensitiveLocation) {
      yield CreateSensitiveLocationWaitingState();

      final remote =
          await PolygonRemoteDataSource().createSensitiveLocation(event.param);
      if (remote.isRight()) {
        var result = Result(
            data: (remote as Right<BaseError, SensitiveLocationModel>).value);
        yield CreateSensitiveLocationSuccessState(result.data);
      } else {
        var error = Result(
            error: (remote as Left<BaseError, SensitiveLocationModel>).value);
        yield CreateSensitiveLocationFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetPolygons) {
      yield GetPolygonsWaitingState();

      final remote = await PolygonRemoteDataSource().getPolygons(event.param);
      if (remote.isRight()) {
        var result =
            Result(data: (remote as Right<BaseError, PolygonsModel>).value);
        yield GetPolygonsSuccessState(result.data);
      } else {
        var error =
            Result(error: (remote as Left<BaseError, PolygonsModel>).value);
        yield GetPolygonsFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetRegions) {
      yield GetRegionsWaitingState();

      final remote = await PolygonRemoteDataSource().getRegions(event.param);
      if (remote.isRight()) {
        var result =
            Result(data: (remote as Right<BaseError, RegionModel>).value);
        yield GetRegionsSuccessState(result.data);
      } else {
        var error =
            Result(error: (remote as Left<BaseError, RegionModel>).value);
        yield GetRegionsFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetRegionTypes) {
      yield GetRegionTypesWaitingState();

      final remote =
          await PolygonRemoteDataSource().getRegionTypes(event.param);
      if (remote.isRight()) {
        var result =
            Result(data: (remote as Right<BaseError, RegionTypeModel>).value);
        yield GetRegionTypesSuccessState(result.data);
      } else {
        var error =
            Result(error: (remote as Left<BaseError, RegionTypeModel>).value);
        yield GetRegionTypesFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetPoliceDepartments) {
      yield GetPoliceDepartmentsWaitingState();

      final remote =
          await PolygonRemoteDataSource().getPoliceDepartments(event.param);
      if (remote.isRight()) {
        var result = Result(
            data: (remote as Right<BaseError, PoliceDepartmentModel>).value);
        yield GetPoliceDepartmentsSuccessState(result.data);
      } else {
        var error = Result(
            error: (remote as Left<BaseError, PoliceDepartmentModel>).value);
        yield GetPoliceDepartmentsFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetAuthorityAreas) {
      yield GetAuthorityAreasWaitingState();

      final remote =
          await PolygonRemoteDataSource().getAuthorityAreas(event.param);
      if (remote.isRight()) {
        var result = Result(
            data: (remote as Right<BaseError, AuthorityAreaModel>).value);
        yield GetAuthorityAreasSuccessState(result.data);
      } else {
        var error = Result(
            error: (remote as Left<BaseError, AuthorityAreaModel>).value);
        yield GetAuthorityAreasFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is CreateAuthorityArea) {
      yield CreateAuthorityAreaWaitingState();

      final remote =
          await PolygonRemoteDataSource().createAuthorityArea(event.param);
      if (remote.isRight()) {
        var result = Result(
            data: (remote as Right<BaseError, AuthorityAreaModel>).value);
        yield CreateAuthorityAreaSuccessState(result.data);
      } else {
        var error = Result(
            error: (remote as Left<BaseError, AuthorityAreaModel>).value);
        yield CreateAuthorityAreaFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetSensitiveLocations) {
      yield GetSensitiveLocationsWaitingState();

      final remote =
          await PolygonRemoteDataSource().getSensitiveLocations(event.param);
      if (remote.isRight()) {
        var result = Result(
            data:
                (remote as Right<BaseError, GetSensitiveLocationModel>).value);
        yield GetSensitiveLocationsSuccessState(result.data);
      } else {
        var error = Result(
            error:
                (remote as Left<BaseError, GetSensitiveLocationModel>).value);
        yield GetSensitiveLocationsFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    }
  }
}
