import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/features/home/domain/usecase/add_reward_usecase.dart';
import 'package:micropolis_test/features/home/domain/usecase/get_steps_usecase.dart';
import 'package:micropolis_test/features/home/domain/usecase/get_user_health_usecase.dart';
import 'package:micropolis_test/features/home/presentation/bloc/steps_event.dart';
import 'package:micropolis_test/features/home/presentation/bloc/steps_state.dart';
import '../../domain/repository/isteps_repository.dart';
import '../../../../service_locator.dart';
import '../../domain/usecase/add_health_point.dart';
import '../../domain/usecase/add_step_usecase.dart';
import '../../domain/usecase/get_rewards_usecase.dart';
import '../../domain/usecase/get_user_steps_usecase.dart';

class StepsBloc extends Bloc<StepsEvent, StepsState> {
  StepsBloc() : super(InitialStepsState());

  @override
  Stream<StepsState> mapEventToState(StepsEvent event) async* {
    if (event is GetSteps) {
      yield GetStepsWaitingState();
      final result =
          await GetStepsUseCase(locator<IStepsRepository>()).call(event.params);
      if (result.hasDataOnly) {
        yield GetStepsSuccessState(result.data!);
      } else if (result.hasErrorOnly) {
        yield GetStepsFailureState(
            error: result.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetUserSteps) {
      yield GetUserStepsWaitingState();
      final result = await GetUserStepsUseCase(locator<IStepsRepository>())
          .call(event.params);
      if (result.hasDataOnly) {
        yield GetUserStepsSuccessState(result.data!);
      } else if (result.hasErrorOnly) {
        yield GetUserStepsFailureState(
            error: result.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is AddUserStep) {
      yield AddUserStepWaitingState();
      final result =
          await AddStepUseCase(locator<IStepsRepository>()).call(event.params);
      if (result.hasDataOnly) {
        yield AddUserStepSuccessState(result.data!);
      } else if (result.hasErrorOnly) {
        yield AddUserStepFailureState(
            error: result.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is AddHealthPoint) {
      yield AddHealthPointWaitingState();
      final result = await AddHealthPointUseCase(locator<IStepsRepository>())
          .call(event.params);
      if (result.hasDataOnly) {
        yield AddHealthPointSuccessState(result.data!);
      } else if (result.hasErrorOnly) {
        yield AddHealthPointFailureState(
            error: result.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetUserHealthPoints) {
      yield GetHealthPointWaitingState();
      final result = await GetUserHealthUseCase(locator<IStepsRepository>())
          .call(event.params);
      if (result.hasDataOnly) {
        yield GetHealthPointSuccessState(result.data!);
      } else if (result.hasErrorOnly) {
        yield GetHealthPointFailureState(
            error: result.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is AddReward) {
      yield AddRewardWaitingState();
      final result = await AddRewardUseCase(locator<IStepsRepository>())
          .call(event.params);
      if (result.hasDataOnly) {
        yield AddRewardSuccessState(result.data!);
      } else if (result.hasErrorOnly) {
        yield AddRewardFailureState(
            error: result.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetMyRewards) {
      yield GetRewardWaitingState();
      final result = await GetUserRewardsUseCase(locator<IStepsRepository>())
          .call(event.params);
      if (result.hasDataOnly) {
        yield GetRewardSuccessState(result.data!);
      } else if (result.hasErrorOnly) {
        yield GetRewardFailureState(
            error: result.error,
            callback: () {
              this.add(event);
            });
      }
    }
  }
}
