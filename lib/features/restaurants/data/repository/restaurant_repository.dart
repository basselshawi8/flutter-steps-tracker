import 'package:dartz/dartz.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/features/restaurants/data/datasource/irestaurants_datasource.dart';
import 'package:micropolis_test/features/restaurants/data/model/menu_model.dart';
import 'package:micropolis_test/features/restaurants/data/model/restaurant_model.dart';
import 'package:micropolis_test/features/restaurants/data/params/get_menu_param.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/menu_entity.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/restaurant_entity.dart';
import 'package:micropolis_test/features/restaurants/domain/repository/irestaurant_repository.dart';

class RestaurantsRepository extends IRestaurantsRepository {

  final IRestaurantsRemoteDataSource iRestaurantsRemoteDataSource;

  RestaurantsRepository(this.iRestaurantsRemoteDataSource);

  @override
  Future<Result<BaseError, RestaurantListEntity>> getRestaurants(NoParams params) async {

    final remote = await iRestaurantsRemoteDataSource
        .getRestaurants(params);
    if (remote.isRight()) {
      return Result(
          data: (remote as Right<BaseError, RestaurantListModel>).value.toEntity());
    } else {
      return Result(
          error: (remote as Left<BaseError, RestaurantListModel>).value);
    }
  }

  @override
  Future<Result<BaseError, RestaurantMenuEntity>> getRestaurantMenu(GetMenuParam params) async{

    final remote = await iRestaurantsRemoteDataSource
        .getRestaurantMenu(params);
    if (remote.isRight()) {
      return Result(
          data: (remote as Right<BaseError, RestaurantMenuModel>).value.toEntity());
    } else {
      return Result(
          error: (remote as Left<BaseError, RestaurantMenuModel>).value);
    }

  }

}