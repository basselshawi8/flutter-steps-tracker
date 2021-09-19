import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/features/map/data/datasource/polygon_datasource.dart';
import 'package:micropolis_test/features/map/data/models/create_polygon_model.dart';
import 'package:micropolis_test/features/map/data/models/polygons_model.dart';

import './bloc.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(InitialMapState());

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is CreatePolygon) {
      yield CreatePolygonWaitingState();

      final remote = await PolygonRemoteDataSource().createPolygon(event.param);
      if (remote.isRight()) {
        var result = Result(
            data: (remote as Right<BaseError, CreatePolygonModel>).value);
        yield CreatePolygonSuccessState(result.data);
      } else {
        var error = Result(
            error: (remote as Left<BaseError, CreatePolygonModel>).value);
        yield CreatePolygonFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    }
    else if (event is GetPolygons) {
      yield GetPolygonsWaitingState();

      final remote = await PolygonRemoteDataSource().getPolygons(event.param);
      if (remote.isRight()) {
        var result = Result(
            data: (remote as Right<BaseError, PolygonsModel>).value);
        yield GetPolygonsSuccessState(result.data);
      } else {
        var error = Result(
            error: (remote as Left<BaseError, PolygonsModel>).value);
        yield GetPolygonsFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    }
  }
}
