import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/core/usecases/usecase.dart';
import 'package:micropolis_test/features/home/data/params/add_health_param.dart';
import 'package:micropolis_test/features/home/domain/repository/isteps_repository.dart';

class AddHealthPointUseCase extends UseCase<bool, AddHealthParam> {
  final IStepsRepository iStepsRepository;

  AddHealthPointUseCase(this.iStepsRepository);

  @override
  Future<Result<BaseError, bool>> call(AddHealthParam params) {
    return iStepsRepository.addHealthPoint(params);
  }
}
