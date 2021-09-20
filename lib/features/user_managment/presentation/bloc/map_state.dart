import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/features/map/data/models/create_polygon_model.dart';
import 'package:micropolis_test/features/map/data/models/polygons_model.dart';

@immutable
abstract class MapState extends Equatable {
  const MapState();
}

class InitialMapState extends MapState {
  const InitialMapState();

  @override
  List<Object> get props => [];
}

/// create polygon
class CreatePolygonWaitingState extends MapState {
  const CreatePolygonWaitingState();

  @override
  List<Object> get props => [];
}

class CreatePolygonSuccessState extends MapState {
  final CreatePolygonModel polygonModel;

  const CreatePolygonSuccessState(this.polygonModel);

  @override
  List<Object> get props => [polygonModel];
}

class CreatePolygonFailureState extends MapState {
  final BaseError error;
  final VoidCallback callback;

  const CreatePolygonFailureState({this.error, this.callback});

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
