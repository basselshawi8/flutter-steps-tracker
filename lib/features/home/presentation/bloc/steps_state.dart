import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micropolis_test/features/home/domain/entity/health_point_entity.dart';
import 'package:micropolis_test/features/home/domain/entity/my_reward_entity.dart';
import 'package:micropolis_test/features/home/domain/entity/steps_entity.dart';
import 'package:micropolis_test/core/errors/base_error.dart';

@immutable
abstract class StepsState extends Equatable {
  const StepsState();
}

class InitialStepsState extends StepsState {
  const InitialStepsState();

  @override
  List<Object> get props => [];
}

/// get steps
class GetStepsWaitingState extends StepsState {
  const GetStepsWaitingState();

  @override
  List<Object> get props => [];
}

class GetStepsSuccessState extends StepsState {
  final List<StepsEntity> steps;

  const GetStepsSuccessState(this.steps);

  @override
  List<Object> get props => [steps];
}

class GetStepsFailureState extends StepsState {
  final BaseError? error;
  final VoidCallback? callback;

  const GetStepsFailureState({this.error, this.callback});

  @override
  List<Object> get props =>
      [if (error != null) error!, if (callback != null) callback!];
}

/// get user steps
class GetUserStepsWaitingState extends StepsState {
  const GetUserStepsWaitingState();

  @override
  List<Object> get props => [];
}

class GetUserStepsSuccessState extends StepsState {
  final List<StepsEntity> steps;

  const GetUserStepsSuccessState(this.steps);

  @override
  List<Object> get props => [steps];
}

class GetUserStepsFailureState extends StepsState {
  final BaseError? error;
  final VoidCallback? callback;

  const GetUserStepsFailureState({this.error, this.callback});

  @override
  List<Object> get props =>
      [if (error != null) error!, if (callback != null) callback!];
}

/// add user step
class AddUserStepWaitingState extends StepsState {
  const AddUserStepWaitingState();

  @override
  List<Object> get props => [];
}

class AddUserStepSuccessState extends StepsState {
  final bool result;

  const AddUserStepSuccessState(this.result);

  @override
  List<Object> get props => [result];
}

class AddUserStepFailureState extends StepsState {
  final BaseError? error;
  final VoidCallback? callback;

  const AddUserStepFailureState({this.error, this.callback});

  @override
  List<Object> get props =>
      [if (error != null) error!, if (callback != null) callback!];
}

/// add health point
class AddHealthPointWaitingState extends StepsState {
  const AddHealthPointWaitingState();

  @override
  List<Object> get props => [];
}

class AddHealthPointSuccessState extends StepsState {
  final bool result;

  const AddHealthPointSuccessState(this.result);

  @override
  List<Object> get props => [result];
}

class AddHealthPointFailureState extends StepsState {
  final BaseError? error;
  final VoidCallback? callback;

  const AddHealthPointFailureState({this.error, this.callback});

  @override
  List<Object> get props =>
      [if (error != null) error!, if (callback != null) callback!];
}

/// get health points
class GetHealthPointWaitingState extends StepsState {
  const GetHealthPointWaitingState();

  @override
  List<Object> get props => [];
}

class GetHealthPointSuccessState extends StepsState {
  final List<HealthPointEntity> points;

  const GetHealthPointSuccessState(this.points);

  @override
  List<Object> get props => [points];
}

class GetHealthPointFailureState extends StepsState {
  final BaseError? error;
  final VoidCallback? callback;

  const GetHealthPointFailureState({this.error, this.callback});

  @override
  List<Object> get props =>
      [if (error != null) error!, if (callback != null) callback!];
}

/// add reward
class AddRewardWaitingState extends StepsState {
  const AddRewardWaitingState();

  @override
  List<Object> get props => [];
}

class AddRewardSuccessState extends StepsState {
  final bool result;

  const AddRewardSuccessState(this.result);

  @override
  List<Object> get props => [result];
}

class AddRewardFailureState extends StepsState {
  final BaseError? error;
  final VoidCallback? callback;

  const AddRewardFailureState({this.error, this.callback});

  @override
  List<Object> get props =>
      [if (error != null) error!, if (callback != null) callback!];
}

/// get reward
class GetRewardWaitingState extends StepsState {
  const GetRewardWaitingState();

  @override
  List<Object> get props => [];
}

class GetRewardSuccessState extends StepsState {
  final List<MyRewardEntity> rewards;

  const GetRewardSuccessState(this.rewards);

  @override
  List<Object> get props => [rewards];
}

class GetRewardFailureState extends StepsState {
  final BaseError? error;
  final VoidCallback? callback;

  const GetRewardFailureState({this.error, this.callback});

  @override
  List<Object> get props =>
      [if (error != null) error!, if (callback != null) callback!];
}
