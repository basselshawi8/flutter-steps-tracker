import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/core/Common/appConfig.dart';
import 'package:micropolis_test/core/utils.dart';
import 'package:micropolis_test/features/home/data/model/health_point_model.dart';
import 'package:micropolis_test/features/home/data/model/steps_model.dart';
import 'package:micropolis_test/features/home/data/params/add_health_param.dart';
import 'package:micropolis_test/features/home/domain/repository/isteps_repository.dart';
import 'package:micropolis_test/navigation_service.dart';
import 'package:micropolis_test/service_locator.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:synchronized/synchronized.dart';

import 'features/home/data/params/add_step_param.dart';
import 'features/home/presentation/bloc/steps_bloc.dart';
import 'features/home/presentation/bloc/steps_event.dart';

var totalSteps = 0;

class PedoMeterUtil {
  static final PedoMeterUtil _singleton = PedoMeterUtil._internal();

  late Stream<StepCount> _stepCountStream;
  late Stream<StepsModel> numberOfStepsStream;
  late StreamController<StepsModel> _numberOfStepsStreamController;
  var lastStepsCount = 0;
  var lock = new Lock();
  var healthPointAdd = 1;

  factory PedoMeterUtil() {
    return _singleton;
  }

  PedoMeterUtil._internal();

  void onStepCount(StepCount event) async {
    await lock.synchronized(() async {
      if (lastStepsCount == 0) {
        lastStepsCount = event.steps;
        return;
      }
      int steps = event.steps - lastStepsCount;
      totalSteps += steps;
      var name = await locator<IStepsRepository>().getUserName();
      var deviceId = appConfig.deviceUniqueIdentifier;
      var model = StepsModel(
          steps: steps, date: DateTime.now(), name: name!, deviceId: deviceId!);
      _numberOfStepsStreamController.add(model);
      BlocProvider.of<StepsBloc>(
              locator<NavigationService>().getNavigationKey.currentContext!)
          .add(AddUserStep(AddStepsParam(stepsModel: model)));
      lastStepsCount = event.steps;
      if (healthPointAdd * 100 < totalSteps) {
        healthPointAdd += 1;
        var healthModel = HealthPointModel(
            date: DateTime.now(),
            name: name!,
            deviceId: deviceId!,
            used: false);
        Future.delayed(Duration(milliseconds: 400)).then((value) {
          BlocProvider.of<StepsBloc>(
                  locator<NavigationService>().getNavigationKey.currentContext!)
              .add(AddHealthPoint(
                  AddHealthParam(healthPointModel: healthModel)));
          showSnackBack(
              locator<NavigationService>().getNavigationKey.currentContext!,
              'You have gained a new Health Point!');
        });
      }
    });
  }

  void onStepCountError(error) {
    /// Handle the error
  }

  Future<void> initPlatformState() async {
    _numberOfStepsStreamController = StreamController<StepsModel>();
    numberOfStepsStream =
        _numberOfStepsStreamController.stream.asBroadcastStream();
    if (await Permission.activityRecognition.request().isGranted) {
      _stepCountStream = Pedometer.stepCountStream;

      _stepCountStream.listen(onStepCount).onError(onStepCountError);
    }
  }
}
