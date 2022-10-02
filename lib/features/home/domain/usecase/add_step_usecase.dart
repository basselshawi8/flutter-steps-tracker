import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/core/usecases/usecase.dart';
import 'package:micropolis_test/features/home/data/params/add_step_param.dart';
import 'package:micropolis_test/features/home/domain/repository/isteps_repository.dart';

class AddStepUseCase extends UseCase<bool, AddStepsParam> {
  final IStepsRepository iStepsRepository;

  AddStepUseCase(this.iStepsRepository);

  @override
  Future<Result<BaseError, bool>> call(AddStepsParam params) {
    return iStepsRepository.addStep(params);
  }
}
