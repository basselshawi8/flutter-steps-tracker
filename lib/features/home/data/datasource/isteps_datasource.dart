import 'package:dartz/dartz.dart';
import 'package:micropolis_test/core/datasources/remote_data_source.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/home/data/model/health_point_model.dart';
import 'package:micropolis_test/features/home/data/model/steps_model.dart';
import 'package:micropolis_test/features/home/data/params/add_health_param.dart';
import 'package:micropolis_test/features/home/data/params/add_reward_param.dart';
import 'package:micropolis_test/features/home/data/params/add_step_param.dart';
import 'package:micropolis_test/features/home/data/params/get_user_steps_param.dart';

import '../model/my_reward_model.dart';

abstract class IStepsRemoteDataSource extends RemoteDataSource {
  Future<Either<BaseError, List<StepsModel>>> getSteps(NoParams params);

  Future<Either<BaseError, List<StepsModel>>> getUserSteps(
      GetUserStepsParam params);

  Future<Either<BaseError, List<MyRewardModel>>> getUserRewards(
      GetUserStepsParam params);

  Future<Either<BaseError, bool>> addStep(AddStepsParam params);

  Future<Either<BaseError, bool>> addReward(AddRewardParam params);

  Future<Either<BaseError, bool>> addHealth(AddHealthParam params);

  Future<Either<BaseError, List<HealthPointModel>>> getUserHealth(
      GetUserStepsParam params);
}
