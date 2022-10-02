import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/core/usecases/usecase.dart';
import 'package:micropolis_test/features/home/domain/entity/steps_entity.dart';
import 'package:micropolis_test/features/home/domain/repository/isteps_repository.dart';

class GetStepsUseCase extends UseCase<List<StepsEntity>, NoParams> {
  final IStepsRepository iStepsRepository;

  GetStepsUseCase(this.iStepsRepository);

  @override
  Future<Result<BaseError, List<StepsEntity>>> call(NoParams params) {
    return iStepsRepository.getSteps(params);
  }
}
