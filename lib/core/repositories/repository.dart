import 'package:micropolis_test/core/models/BaseModel.dart';
import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';

import '../entities/base_entity.dart';
import '../errors/base_error.dart';
import '../results/result.dart';

abstract class Repository {
  Result<BaseError, Entity>
      execute<Model extends BaseModel<Entity>, Entity extends BaseEntity>({
    @required Either<BaseError, Model> remoteResult,
  }) {
    if (remoteResult.isRight()) {
      return Result(
        data: (remoteResult as Right<BaseError, Model>).value.toEntity(),
      );
    } else {
      return Result(error: (remoteResult as Left<BaseError, Model>).value);
    }
  }

  Result<BaseError, T> executeForNoEntity<T>({
    @required Either<BaseError, T> remoteResult,
  }) {
    if (remoteResult.isRight()) {
      return Result(data: (remoteResult as Right<BaseError, T>).value,);
    } else {
      return Result(error: (remoteResult as Left<BaseError, T>).value);
    }
  }

  Result<BaseError, List<Entity>> executeForList<
  Model extends BaseModel<Entity>, Entity extends BaseEntity>(
      {@required Either<BaseError, Entity> remoteResult}) {
    if (remoteResult.isRight()) {
      return Result(
        data: (remoteResult as Right<BaseError, List<Model>>)
            .value
            .map((model) => model.toEntity())
            .toList(),
      );
    } else {
      return Result(
        error: (remoteResult as Left<BaseError, List<Model>>).value,
      );
    }
  }

  Result<BaseError, Object> executeForNoData({
    @required Either<BaseError, Object> remoteResult,
  }) {
    if (remoteResult.isRight()) {
      return Result(data: (remoteResult as Right<BaseError, Object>).value);
    }
    else {
      return Result(error: (remoteResult as Left<BaseError, Object>).value);
    }
  }
}
