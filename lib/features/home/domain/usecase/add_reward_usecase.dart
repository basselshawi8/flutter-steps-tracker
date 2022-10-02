import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/core/usecases/usecase.dart';
import 'package:micropolis_test/features/home/data/params/add_reward_param.dart';
import 'package:micropolis_test/features/home/domain/repository/isteps_repository.dart';

class AddRewardUseCase extends UseCase<bool, AddRewardParam> {
  final IStepsRepository iStepsRepository;

  AddRewardUseCase(this.iStepsRepository);

  @override
  Future<Result<BaseError, bool>> call(AddRewardParam params) {
    return iStepsRepository.addReward(params);
  }
}
