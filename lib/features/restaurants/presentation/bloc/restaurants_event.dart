
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RestaurantsEvent extends Equatable{
  const RestaurantsEvent();
}


class GetRestaurants extends RestaurantsEvent{

  final CancelToken cancelToken;

  GetRestaurants(this.cancelToken);
  @override
  List<Object> get props => [];

}

class GetRestaurantMenu extends RestaurantsEvent{

  final CancelToken cancelToken;
  final int restaurantID;

  GetRestaurantMenu(this.cancelToken, this.restaurantID);


  @override
  List<Object> get props => [this.restaurantID];

}
