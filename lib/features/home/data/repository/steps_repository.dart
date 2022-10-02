import 'package:dartz/dartz.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/features/home/data/datasource/isteps_datasource.dart';
import 'package:micropolis_test/features/home/data/model/health_point_model.dart';
import 'package:micropolis_test/features/home/data/model/my_reward_model.dart';
import 'package:micropolis_test/features/home/data/model/steps_model.dart';
import 'package:micropolis_test/features/home/data/params/add_health_param.dart';
import 'package:micropolis_test/features/home/data/params/add_reward_param.dart';
import 'package:micropolis_test/features/home/data/params/add_step_param.dart';
import 'package:micropolis_test/features/home/data/params/get_user_steps_param.dart';
import 'package:micropolis_test/features/home/domain/entity/health_point_entity.dart';
import 'package:micropolis_test/features/home/domain/entity/my_reward_entity.dart';
import 'package:micropolis_test/features/home/domain/entity/steps_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repository/isteps_repository.dart';

const String USER_NAME_KEY = 'userNameKey';

class StepsRepository extends IStepsRepository {
  final IStepsRemoteDataSource iStepsRemoteDataSource;

  StepsRepository(this.iStepsRemoteDataSource);

  SharedPreferences? _sp;

  @override
  Future<Result<BaseError, List<StepsEntity>>> getSteps(NoParams params) async {
    final remote = await iStepsRemoteDataSource.getSteps(params);
    if (remote.isRight()) {
      return Result(
          data: (remote as Right<BaseError, List<StepsModel>>)
              .value
              .map((e) => e.toEntity())
              .toList());
    } else {
      return Result(error: (remote as Left<BaseError, List<StepsModel>>).value);
    }
  }

  @override
  Future<String?> getUserName() async {
    if (_sp == null) {
      _sp = await SharedPreferences.getInstance();
    }

    return _sp!.getString(USER_NAME_KEY);
  }

  @override
  Future<bool> saveUserName(String name) async {
    if (_sp == null) {
      _sp = await SharedPreferences.getInstance();
    }

    return _sp!.setString(USER_NAME_KEY, name);
  }

  @override
  Future<Result<BaseError, bool>> addStep(AddStepsParam params) async {
    final remote = await iStepsRemoteDataSource.addStep(params);
    if (remote.isRight()) {
      return Result(data: (remote as Right<BaseError, bool>).value);
    } else {
      return Result(error: (remote as Left<BaseError, bool>).value);
    }
  }

  @override
  Future<Result<BaseError, List<StepsEntity>>> getUserSteps(
      GetUserStepsParam params) async {
    final remote = await iStepsRemoteDataSource.getUserSteps(params);
    if (remote.isRight()) {
      return Result(
          data: (remote as Right<BaseError, List<StepsModel>>)
              .value
              .map((e) => e.toEntity())
              .toList());
    } else {
      return Result(error: (remote as Left<BaseError, List<StepsModel>>).value);
    }
  }

  @override
  Future<Result<BaseError, bool>> addHealthPoint(AddHealthParam params) async {
    final remote = await iStepsRemoteDataSource.addHealth(params);
    if (remote.isRight()) {
      return Result(data: (remote as Right<BaseError, bool>).value);
    } else {
      return Result(error: (remote as Left<BaseError, bool>).value);
    }
  }

  @override
  Future<Result<BaseError, List<HealthPointEntity>>> getUserHealthPoints(
      GetUserStepsParam params) async {
    final remote = await iStepsRemoteDataSource.getUserHealth(params);
    if (remote.isRight()) {
      return Result(
          data: (remote as Right<BaseError, List<HealthPointModel>>)
              .value
              .map((e) => e.toEntity())
              .toList());
    } else {
      return Result(
          error: (remote as Left<BaseError, List<HealthPointModel>>).value);
    }
  }

  @override
  Future<Result<BaseError, bool>> addReward(AddRewardParam params) async {
    final remote = await iStepsRemoteDataSource.addReward(params);
    if (remote.isRight()) {
      return Result(data: (remote as Right<BaseError, bool>).value);
    } else {
      return Result(error: (remote as Left<BaseError, bool>).value);
    }
  }

  @override
  Future<Result<BaseError, List<MyRewardEntity>>> getUserRewards(
      GetUserStepsParam params) async {
    final remote = await iStepsRemoteDataSource.getUserRewards(params);
    if (remote.isRight()) {
      return Result(
          data: (remote as Right<BaseError, List<MyRewardModel>>)
              .value
              .map((e) => e.toEntity())
              .toList());
    } else {
      return Result(
          error: (remote as Left<BaseError, List<MyRewardModel>>).value);
    }
  }
}
