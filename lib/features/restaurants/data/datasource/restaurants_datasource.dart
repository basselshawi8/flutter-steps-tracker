
import 'package:dartz/dartz.dart';

import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/http/api_url.dart';
import 'package:micropolis_test/core/http/http_method.dart';

import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/restaurants/data/model/menu_model.dart';

import 'package:micropolis_test/features/restaurants/data/model/restaurant_model.dart';
import 'package:micropolis_test/features/restaurants/data/params/get_menu_param.dart';

import 'irestaurants_datasource.dart';

class RestaurantsRemoteDataSource extends IRestaurantsRemoteDataSource {
  @override
  Future<Either<BaseError, RestaurantListModel>> getRestaurants(NoParams params) {
    return request(
        converter: (json) => RestaurantListModel.fromMap(json),
        method: HttpMethod.GET,
        url: API_RESTAURANTS,
        withAuthentication: true,
        isList: true,
        cancelToken: params.cancelToken);

  }

  @override
  Future<Either<BaseError, RestaurantMenuModel>> getRestaurantMenu(GetMenuParam params) {

    return request(
        converter: (json) => RestaurantMenuModel.fromMap(json),
        method: HttpMethod.GET,
        url: "$API_MENUS/${params.restaurantID}",
        withAuthentication: true,
        isList: true,
        cancelToken: params.cancelToken);

  }

}