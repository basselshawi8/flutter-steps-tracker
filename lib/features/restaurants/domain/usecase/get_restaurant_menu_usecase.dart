import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/core/usecases/usecase.dart';
import 'package:micropolis_test/features/restaurants/data/params/get_menu_param.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/menu_entity.dart';
import 'package:micropolis_test/features/restaurants/domain/repository/irestaurant_repository.dart';

class GetRestaurantMenuUseCase
    extends UseCase<RestaurantMenuEntity, GetMenuParam> {
  final IRestaurantsRepository iRestaurantsRepository;

  GetRestaurantMenuUseCase(this.iRestaurantsRepository);

  @override
  Future<Result<BaseError, RestaurantMenuEntity>> call(GetMenuParam params) {
    return iRestaurantsRepository.getRestaurantMenu(params);
  }
}
