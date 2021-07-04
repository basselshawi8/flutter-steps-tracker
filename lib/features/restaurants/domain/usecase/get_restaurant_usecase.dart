import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/core/usecases/usecase.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/restaurant_entity.dart';
import 'package:micropolis_test/features/restaurants/domain/repository/irestaurant_repository.dart';

class GetRestaurantsUseCase
    extends UseCase<RestaurantListEntity, NoParams> {
  final IRestaurantsRepository iRestaurantsRepository;

  GetRestaurantsUseCase(this.iRestaurantsRepository);

  @override
  Future<Result<BaseError, RestaurantListEntity>> call(
      NoParams params) {
    return iRestaurantsRepository.getRestaurants(params);
  }
}