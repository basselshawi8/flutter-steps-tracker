import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/core/usecases/usecase.dart';
import 'package:micropolis_test/features/home/data/params/get_user_steps_param.dart';
import 'package:micropolis_test/features/home/domain/entity/my_reward_entity.dart';
import 'package:micropolis_test/features/home/domain/repository/isteps_repository.dart';

class GetUserRewardsUseCase
    extends UseCase<List<MyRewardEntity>, GetUserStepsParam> {
  final IStepsRepository iStepsRepository;

  GetUserRewardsUseCase(this.iStepsRepository);

  @override
  Future<Result<BaseError, List<MyRewardEntity>>> call(
      GetUserStepsParam params) {
    return iStepsRepository.getUserRewards(params);
  }
}
