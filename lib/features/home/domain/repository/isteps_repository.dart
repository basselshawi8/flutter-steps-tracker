import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/core/repositories/repository.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/features/home/data/params/add_health_param.dart';
import 'package:micropolis_test/features/home/data/params/add_reward_param.dart';
import 'package:micropolis_test/features/home/data/params/add_step_param.dart';
import 'package:micropolis_test/features/home/data/params/get_user_steps_param.dart';
import 'package:micropolis_test/features/home/domain/entity/health_point_entity.dart';
import 'package:micropolis_test/features/home/domain/entity/my_reward_entity.dart';
import 'package:micropolis_test/features/home/domain/entity/steps_entity.dart';

abstract class IStepsRepository extends Repository {
  Future<Result<BaseError, List<StepsEntity>>> getSteps(NoParams params);

  Future<Result<BaseError, List<StepsEntity>>> getUserSteps(
      GetUserStepsParam params);

  Future<Result<BaseError, List<MyRewardEntity>>> getUserRewards(
      GetUserStepsParam params);

  Future<Result<BaseError, List<HealthPointEntity>>> getUserHealthPoints(
      GetUserStepsParam params);

  Future<Result<BaseError, bool>> addHealthPoint(AddHealthParam params);

  Future<Result<BaseError, bool>> addReward(AddRewardParam params);

  Future<Result<BaseError, bool>> addStep(AddStepsParam params);

  Future<bool> saveUserName(String name);

  Future<String?> getUserName();
}
