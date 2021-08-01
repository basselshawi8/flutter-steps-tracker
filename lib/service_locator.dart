import 'package:get_it/get_it.dart';
import 'package:micropolis_test/features/camera/data/datasource/iIncidents_datasource.dart';
import 'package:micropolis_test/features/camera/data/datasource/incidents_datasource.dart';
import 'package:micropolis_test/features/camera/domain/repository/iIncidents_repository.dart';
import 'features/camera/data/repository/incident_repository.dart';
import 'features/restaurants/data/datasource/irestaurants_datasource.dart';
import 'features/restaurants/data/datasource/restaurants_datasource.dart';
import 'features/restaurants/data/repository/restaurant_repository.dart';
import 'features/restaurants/domain/repository/irestaurant_repository.dart';
import 'navigation_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Register Service .
  locator.registerLazySingleton<NavigationService>(() => NavigationService());

  locator.registerFactory<IRestaurantsRemoteDataSource>(
    () => RestaurantsRemoteDataSource(),
  );
  locator.registerFactory<IRestaurantsRepository>(
      () => RestaurantsRepository(locator<IRestaurantsRemoteDataSource>()));

  locator.registerFactory<IIncidentsRemoteDataSource>(
    () => IncidentsRemoteDataSource(),
  );
  locator.registerFactory<IIncidentsRepository>(
      () => IncidentRepository(locator<IIncidentsRemoteDataSource>()));
}
