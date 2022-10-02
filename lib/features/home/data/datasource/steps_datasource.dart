import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:micropolis_test/core/Common/appConfig.dart';

import 'package:micropolis_test/core/errors/base_error.dart';

import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/home/data/model/health_point_model.dart';
import 'package:micropolis_test/features/home/data/model/my_reward_model.dart';
import 'package:micropolis_test/features/home/data/model/steps_model.dart';
import 'package:micropolis_test/features/home/data/params/add_health_param.dart';
import 'package:micropolis_test/features/home/data/params/add_reward_param.dart';
import 'package:micropolis_test/features/home/data/params/add_step_param.dart';
import 'package:micropolis_test/features/home/data/params/get_user_steps_param.dart';

import 'isteps_datasource.dart';

class StepsRemoteDataSource extends IStepsRemoteDataSource {
  @override
  Future<Either<BaseError, List<StepsModel>>> getSteps(NoParams params) async {
    var _fireStore = FirebaseFirestore.instance;
    var stepsFireStore = await _fireStore.collection('steps').get();
    List<StepsModel> steps = [];
    for (var stepRaw in stepsFireStore.docs) {
      steps.add(StepsModel.fromMap(stepRaw.data()));
    }
    return Right(steps);
  }

  @override
  Future<Either<BaseError, bool>> addStep(AddStepsParam params) async {
    var _fireStore = FirebaseFirestore.instance;
    var stepsFireStore = _fireStore.collection('steps');

    stepsFireStore.add(params.toMap());
    return Right(true);
  }

  @override
  Future<Either<BaseError, List<StepsModel>>> getUserSteps(
      GetUserStepsParam params) async {
    var _fireStore = FirebaseFirestore.instance;
    var stepsFireStore = await _fireStore
        .collection('steps')
        .where('deviceId', isEqualTo: params.deviceId)
        .get();
    List<StepsModel> steps = [];
    for (var stepRaw in stepsFireStore.docs) {
      steps.add(StepsModel.fromMap(stepRaw.data()));
    }
    return Right(steps);
  }

  @override
  Future<Either<BaseError, bool>> addHealth(AddHealthParam params) async {
    var _fireStore = FirebaseFirestore.instance;
    var stepsFireStore = _fireStore.collection('health');

    stepsFireStore.add(params.toMap());
    return Right(true);
  }

  @override
  Future<Either<BaseError, List<HealthPointModel>>> getUserHealth(
      GetUserStepsParam params) async {
    var _fireStore = FirebaseFirestore.instance;
    var stepsFireStore = await _fireStore
        .collection('health')
        .where('deviceId', isEqualTo: params.deviceId)
        .get();
    List<HealthPointModel> healths = [];
    for (var healthRaw in stepsFireStore.docs) {
      healths.add(HealthPointModel.fromMap(healthRaw.data()));
    }
    return Right(healths);
  }

  @override
  Future<Either<BaseError, bool>> addReward(AddRewardParam params) async {
    var _fireStore = FirebaseFirestore.instance;

    var healthToEdit = await _fireStore
        .collection('health')
        .where('deviceId', isEqualTo: appConfig.deviceUniqueIdentifier!)
        .where('used', isEqualTo: false)
        .limit(params.rewardModel.price)
        .get()
        .then((QuerySnapshot snapshot) {
      return snapshot.docs[0].reference;
    });

    var batch = _fireStore.batch();

    batch.update(healthToEdit, {'used': true});
    batch.commit();

    var stepsFireStore = _fireStore.collection('rewards');
    stepsFireStore.add(params.toMap());
    return Right(true);
  }

  @override
  Future<Either<BaseError, List<MyRewardModel>>> getUserRewards(
      GetUserStepsParam params) async {
    var _fireStore = FirebaseFirestore.instance;
    var rewardsFireStore = await _fireStore
        .collection('rewards')
        .where('deviceId', isEqualTo: params.deviceId)
        .get();
    List<MyRewardModel> rewards = [];
    for (var rewardRaw in rewardsFireStore.docs) {
      rewards.add(MyRewardModel.fromMap(rewardRaw.data()));
    }
    return Right(rewards);
  }
}
