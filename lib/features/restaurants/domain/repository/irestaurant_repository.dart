import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/core/repositories/repository.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/features/restaurants/data/params/get_menu_param.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/menu_entity.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/restaurant_entity.dart';

abstract class IRestaurantsRepository extends Repository {

  Future<Result<BaseError, RestaurantListEntity>> getRestaurants(
      NoParams params);

  Future<Result<BaseError, RestaurantMenuEntity>> getRestaurantMenu(
      GetMenuParam params);

}