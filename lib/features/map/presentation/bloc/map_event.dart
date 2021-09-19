import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/map/data/params/add_polygon_param.dart';

@immutable
abstract class MapEvent extends Equatable {
  const MapEvent();
}

class CreatePolygon extends MapEvent {
  final AddPolygonParam param;

  CreatePolygon(this.param);

  @override
  List<Object> get props => [this.param];
}

class GetPolygons extends MapEvent {
  final NoParams param;

  GetPolygons(this.param);

  @override
  List<Object> get props => [this.param];
}
