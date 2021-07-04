import '../params/base_params.dart';
import '../errors/base_error.dart';
import '../results/result.dart';

abstract class UseCase<Type, Params extends BaseParams> {
  Future<Result<BaseError, Type>> call(Params params);
}

abstract class TwoModelsUseCase<Type1, Type, Params extends BaseParams> {
  Future<Result<BaseError, TwoModelsResult<Type1, Type>>> call(Params params);
}
