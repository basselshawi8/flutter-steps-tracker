import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/features/user_managment/data/datasource/usermanagment_datasource.dart';
import 'package:micropolis_test/features/user_managment/data/models/create_behavioral_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/create_facial_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/create_human_detection_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/create_user_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/get_behavioral_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/get_facial_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/get_human_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/role_list_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/users_list_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/vechile_list_model.dart';
import 'package:micropolis_test/features/user_managment/presentation/widgets/add_vehicle_widget.dart';

import '../../../../main.dart';
import './bloc.dart';

class UserManagementBloc
    extends Bloc<UserManagementEvent, UserManagementState> {
  UserManagementBloc() : super(InitialUserManagementState());

  @override
  Stream<UserManagementState> mapEventToState(
      UserManagementEvent event) async* {
    if (event is CreateUser) {
      yield CreateUserWaitingState();

      final remote =
          await UserManagementRemoteDataSource().createUser(event.param);
      if (remote.isRight()) {
        var result =
            Result(data: (remote as Right<BaseError, CreateUserModel>).value);
        yield CreateUserSuccessState(result.data);
      } else {
        var error =
            Result(error: (remote as Left<BaseError, CreateUserModel>).value);
        yield CreateUserFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetUsers) {
      yield GetUsersWaitingState();

      final remote =
          await UserManagementRemoteDataSource().getUsers(event.param);
      if (remote.isRight()) {
        var result =
            Result(data: (remote as Right<BaseError, UsersListModel>).value);
        yield GetUsersSuccessState(result.data);
      } else {
        var error =
            Result(error: (remote as Left<BaseError, UsersListModel>).value);
        yield GetUsersFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetRoles) {
      yield GetRolesWaitingState();

      final remote =
          await UserManagementRemoteDataSource().getRoles(event.param);
      if (remote.isRight()) {
        var result =
            Result(data: (remote as Right<BaseError, RoleListModel>).value);
        yield GetRolesSuccessState(result.data);
      } else {
        var error =
            Result(error: (remote as Left<BaseError, RoleListModel>).value);
        yield GetRolesFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetVehicles) {
      yield GetVehiclesWaitingState();

      final remote =
          await UserManagementRemoteDataSource().getVehicles(event.param);
      if (remote.isRight()) {
        var result =
            Result(data: (remote as Right<BaseError, VehicleListModel>).value);
        yield GetVehiclesSuccessState(result.data);
      } else {
        var error =
            Result(error: (remote as Left<BaseError, VehicleListModel>).value);
        yield GetVehiclesFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is CreateBehavioralAnalysis) {
      yield CreateBehavioralAnalysisWaitingState();

      final remote =
          await UserManagementRemoteDataSource().createBehavioral(event.param);
      if (remote.isRight()) {
        var result = Result(
            data: (remote as Right<BaseError, CreateBehavioralModel>).value);
        mqttHelper.publishBehavior(behavioralAnalysisActive, result.data);
        yield CreateBehavioralAnalysisSuccessState(result.data);
      } else {
        var error = Result(
            error: (remote as Left<BaseError, CreateBehavioralModel>).value);
        yield CreateBehavioralAnalysisFailureStat(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is CreateFacialRecognition) {
      yield CreateFacialRecognitionWaitingState();

      final remote =
          await UserManagementRemoteDataSource().createFacial(event.param);
      if (remote.isRight()) {
        var result =
            Result(data: (remote as Right<BaseError, CreateFacialModel>).value);
        mqttHelper.publishFacial(facialActive, result.data);
        yield CreateFacialRecognitionSuccessState(result.data);
      } else {
        var error =
            Result(error: (remote as Left<BaseError, CreateFacialModel>).value);
        yield CreateFacialRecognitionFailureStat(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is CreateHumanDetection) {
      yield CreateHumanDetectionWaitingState();

      final remote = await UserManagementRemoteDataSource()
          .createHumanDetection(event.param);
      if (remote.isRight()) {
        var result = Result(
            data:
                (remote as Right<BaseError, CreateHumanDetectionModel>).value);
        mqttHelper.publishHuman(humanActive, result.data);
        yield CreateHumanDetectionSuccessState(result.data);
      } else {
        var error = Result(
            error:
                (remote as Left<BaseError, CreateHumanDetectionModel>).value);
        yield CreateHumanDetectionFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetFacial) {
      yield GetFacialRecognitionWaitingState();

      final remote = await UserManagementRemoteDataSource()
          .getFacialRecognition(event.param);
      if (remote.isRight()) {
        var result = Result(
            data:
                (remote as Right<BaseError, GetFacialRecognitionModel>).value);
        yield GetFacialRecognitionSuccessState(result.data);
      } else {
        var error = Result(
            error:
                (remote as Left<BaseError, GetFacialRecognitionModel>).value);
        yield GetFacialRecognitionFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetBehavioral) {
      yield GetBehavioralAnalysisWaitingState();

      final remote = await UserManagementRemoteDataSource()
          .getBehavioralAnalysis(event.param);
      if (remote.isRight()) {
        var result = Result(
            data:
                (remote as Right<BaseError, GetBehavioralAnalysisModel>).value);
        yield GetBehavioralAnalysisSuccessState(result.data);
      } else {
        var error = Result(
            error:
                (remote as Left<BaseError, GetBehavioralAnalysisModel>).value);
        yield GetBehavioralAnalysisFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetHumanDetection) {
      yield GetHumanDetectionWaitingState();

      final remote =
          await UserManagementRemoteDataSource().getHumanDetection(event.param);
      if (remote.isRight()) {
        var result = Result(
            data: (remote as Right<BaseError, GetHumanDetectionModel>).value);

        yield GetHumanDetectionSuccessState(result.data);
      } else {
        var error = Result(
            error: (remote as Left<BaseError, GetHumanDetectionModel>).value);
        yield GetHumanDetectionFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    }
  }
}
