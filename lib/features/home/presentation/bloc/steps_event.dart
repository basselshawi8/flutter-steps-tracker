import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/home/data/params/add_health_param.dart';
import 'package:micropolis_test/features/home/data/params/add_reward_param.dart';
import 'package:micropolis_test/features/home/data/params/add_step_param.dart';
import 'package:micropolis_test/features/home/data/params/get_user_steps_param.dart';

@immutable
abstract class StepsEvent extends Equatable {
  const StepsEvent();
}

class GetSteps extends StepsEvent {
  final NoParams params;

  GetSteps(this.params);

  @override
  List<Object> get props => [];
}

class GetUserSteps extends StepsEvent {
  final GetUserStepsParam params;

  GetUserSteps(this.params);

  @override
  List<Object> get props => [];
}

class GetUserHealthPoints extends StepsEvent {
  final GetUserStepsParam params;

  GetUserHealthPoints(this.params);

  @override
  List<Object> get props => [];
}

class AddUserStep extends StepsEvent {
  final AddStepsParam params;

  AddUserStep(this.params);

  @override
  List<Object> get props => [];
}

class AddHealthPoint extends StepsEvent {
  final AddHealthParam params;

  AddHealthPoint(this.params);

  @override
  List<Object> get props => [];
}

class AddReward extends StepsEvent {
  final AddRewardParam params;

  AddReward(this.params);

  @override
  List<Object> get props => [];
}

class GetMyRewards extends StepsEvent {
  final GetUserStepsParam params;

  GetMyRewards(this.params);

  @override
  List<Object> get props => [];
}
