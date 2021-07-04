import 'package:dartz/dartz.dart';
import 'package:micropolis_test/core/datasources/remote_data_source.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/restaurants/data/model/menu_model.dart';
import 'package:micropolis_test/features/restaurants/data/model/restaurant_model.dart';
import 'package:micropolis_test/features/restaurants/data/params/get_menu_param.dart';

abstract class IRestaurantsRemoteDataSource extends RemoteDataSource {
  Future<Either<BaseError, RestaurantListModel>> getRestaurants(
      NoParams params);

  Future<Either<BaseError, RestaurantMenuModel>> getRestaurantMenu(
      GetMenuParam params);

}
