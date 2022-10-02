import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/core/usecases/usecase.dart';
import 'package:micropolis_test/features/home/data/params/get_user_steps_param.dart';
import 'package:micropolis_test/features/home/domain/entity/steps_entity.dart';
import 'package:micropolis_test/features/home/domain/repository/isteps_repository.dart';

class GetUserStepsUseCase extends UseCase<List<StepsEntity>, GetUserStepsParam> {
  final IStepsRepository iStepsRepository;

  GetUserStepsUseCase(this.iStepsRepository);

  @override
  Future<Result<BaseError, List<StepsEntity>>> call(GetUserStepsParam params) {
    return iStepsRepository.getUserSteps(params);
  }
}
