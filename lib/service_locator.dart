import 'package:get_it/get_it.dart';
import 'package:micropolis_test/PedoMeterUtil.dart';
import 'package:micropolis_test/features/home/data/datasource/isteps_datasource.dart';
import 'package:micropolis_test/features/home/data/datasource/steps_datasource.dart';
import 'package:micropolis_test/features/home/domain/repository/isteps_repository.dart';
import 'features/home/data/repository/steps_repository.dart';
import 'navigation_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Register Service .
  locator.registerLazySingleton<NavigationService>(() => NavigationService());

  locator.registerFactory<IStepsRemoteDataSource>(
    () => StepsRemoteDataSource(),
  );

  locator.registerFactory<IStepsRepository>(
      () => StepsRepository(locator<IStepsRemoteDataSource>()));
  locator.registerSingleton<PedoMeterUtil>(PedoMeterUtil());
  locator<PedoMeterUtil>().initPlatformState();
}
