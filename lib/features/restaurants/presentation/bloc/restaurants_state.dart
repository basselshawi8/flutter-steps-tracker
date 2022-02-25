
import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/menu_entity.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/restaurant_entity.dart';
import 'package:micropolis_test/core/errors/base_error.dart';

@immutable
abstract class RestaurantsState extends Equatable {
  const RestaurantsState();
}

class InitialRestaurantState extends RestaurantsState {
  const InitialRestaurantState();
  @override
  List<Object> get props => [];

}

/// GetAddress
class GetRestaurantsWaitingState extends RestaurantsState {
  const GetRestaurantsWaitingState();
  @override
  List<Object> get props => [];
}

class GetRestaurantsSuccessState extends RestaurantsState {
  final RestaurantListEntity restaurantsList;
  const GetRestaurantsSuccessState(this.restaurantsList);
  @override
  List<Object> get props => [restaurantsList];
}

class GetRestaurantMenuSuccessState extends RestaurantsState {
  final RestaurantMenuEntity menu;
  const GetRestaurantMenuSuccessState(this.menu);
  @override
  List<Object> get props => [menu];
}

class GetRestaurantsFailureState extends RestaurantsState {
  final BaseError error;
  final VoidCallback callback;

  const GetRestaurantsFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}
