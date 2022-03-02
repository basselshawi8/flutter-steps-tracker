import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/restaurants/data/params/get_menu_param.dart';
import 'package:micropolis_test/features/restaurants/domain/repository/irestaurant_repository.dart';
import 'package:micropolis_test/features/restaurants/domain/usecase/get_restaurant_menu_usecase.dart';
import 'package:micropolis_test/features/restaurants/domain/usecase/get_restaurant_usecase.dart';

import './bloc.dart';
import '../../../../service_locator.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  RestaurantsBloc() : super(InitialRestaurantState());

  @override
  Stream<RestaurantsState> mapEventToState(RestaurantsEvent event) async* {
    if (event is GetRestaurants) {
      yield GetRestaurantsWaitingState();
      final result =
          await GetRestaurantsUseCase(locator<IRestaurantsRepository>())
              .call(NoParams(cancelToken: event.cancelToken));
      if (result.hasDataOnly) {
        yield GetRestaurantsSuccessState(result.data!);
      } else if (result.hasErrorOnly) {
        yield GetRestaurantsFailureState(
            error: result.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetRestaurantMenu) {
      yield GetRestaurantsWaitingState();

      final result =
          await GetRestaurantMenuUseCase(locator<IRestaurantsRepository>())
              .call(GetMenuParam(
                  cancelToken: event.cancelToken,
                  restaurantID: event.restaurantID));
      if (result.hasDataOnly) {
        yield GetRestaurantMenuSuccessState(result.data!);
      } else if (result.hasErrorOnly) {
        yield GetRestaurantsFailureState(
            error: result.error,
            callback: () {
              this.add(event);
            });
      }
    }
  }
}
