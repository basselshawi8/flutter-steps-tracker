import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/core/usecases/usecase.dart';
import 'package:micropolis_test/features/home/data/params/get_user_steps_param.dart';
import 'package:micropolis_test/features/home/domain/entity/health_point_entity.dart';
import 'package:micropolis_test/features/home/domain/repository/isteps_repository.dart';

class GetUserHealthUseCase
    extends UseCase<List<HealthPointEntity>, GetUserStepsParam> {
  final IStepsRepository iStepsRepository;

  GetUserHealthUseCase(this.iStepsRepository);

  @override
  Future<Result<BaseError, List<HealthPointEntity>>> call(
      GetUserStepsParam params) {
    return iStepsRepository.getUserHealthPoints(params);
  }
}
