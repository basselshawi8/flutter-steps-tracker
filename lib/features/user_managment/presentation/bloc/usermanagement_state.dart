import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
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

@immutable
abstract class UserManagementState extends Equatable {
  const UserManagementState();
}

class InitialUserManagementState extends UserManagementState {
  const InitialUserManagementState();

  @override
  List<Object> get props => [];
}

/// create user
class CreateUserWaitingState extends UserManagementState {
  const CreateUserWaitingState();

  @override
  List<Object> get props => [];
}

class CreateUserSuccessState extends UserManagementState {
  final CreateUserModel userModel;

  const CreateUserSuccessState(this.userModel);

  @override
  List<Object> get props => [userModel];
}

class CreateUserFailureState extends UserManagementState {
  final BaseError error;
  final VoidCallback callback;

  const CreateUserFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}

/// get users
class GetUsersWaitingState extends UserManagementState {
  const GetUsersWaitingState();

  @override
  List<Object> get props => [];
}

class GetUsersSuccessState extends UserManagementState {
  final UsersListModel users;

  const GetUsersSuccessState(this.users);

  @override
  List<Object> get props => [users];
}

class GetUsersFailureState extends UserManagementState {
  final BaseError error;
  final VoidCallback callback;

  const GetUsersFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}

/// get roles
class GetRolesWaitingState extends UserManagementState {
  const GetRolesWaitingState();

  @override
  List<Object> get props => [];
}

class GetRolesSuccessState extends UserManagementState {
  final RoleListModel roles;

  const GetRolesSuccessState(this.roles);

  @override
  List<Object> get props => [roles];
}

class GetRolesFailureState extends UserManagementState {
  final BaseError error;
  final VoidCallback callback;

  const GetRolesFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}

/// get vehicles
class GetVehiclesWaitingState extends UserManagementState {
  const GetVehiclesWaitingState();

  @override
  List<Object> get props => [];
}

class GetVehiclesSuccessState extends UserManagementState {
  final VehicleListModel vehicles;

  const GetVehiclesSuccessState(this.vehicles);

  @override
  List<Object> get props => [vehicles];
}

class GetVehiclesFailureState extends UserManagementState {
  final BaseError error;
  final VoidCallback callback;

  const GetVehiclesFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}

/// create bahavioral
class CreateBehavioralAnalysisWaitingState extends UserManagementState {
  const CreateBehavioralAnalysisWaitingState();

  @override
  List<Object> get props => [];
}

class CreateBehavioralAnalysisSuccessState extends UserManagementState {
  final CreateBehavioralModel behavioral;

  const CreateBehavioralAnalysisSuccessState(this.behavioral);

  @override
  List<Object> get props => [behavioral];
}

class CreateBehavioralAnalysisFailureStat extends UserManagementState {
  final BaseError error;
  final VoidCallback callback;

  const CreateBehavioralAnalysisFailureStat({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}

/// create facial
class CreateFacialRecognitionWaitingState extends UserManagementState {
  const CreateFacialRecognitionWaitingState();

  @override
  List<Object> get props => [];
}

class CreateFacialRecognitionSuccessState extends UserManagementState {
  final CreateFacialModel facial;

  const CreateFacialRecognitionSuccessState(this.facial);

  @override
  List<Object> get props => [facial];
}

class CreateFacialRecognitionFailureStat extends UserManagementState {
  final BaseError error;
  final VoidCallback callback;

  const CreateFacialRecognitionFailureStat({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}

/// create human detection
class CreateHumanDetectionWaitingState extends UserManagementState {
  const CreateHumanDetectionWaitingState();

  @override
  List<Object> get props => [];
}

class CreateHumanDetectionSuccessState extends UserManagementState {
  final CreateHumanDetectionModel detectionModel;

  const CreateHumanDetectionSuccessState(this.detectionModel);

  @override
  List<Object> get props => [detectionModel];
}

class CreateHumanDetectionFailureState extends UserManagementState {
  final BaseError error;
  final VoidCallback callback;

  const CreateHumanDetectionFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}

/// Get Facial Model
class GetFacialRecognitionWaitingState extends UserManagementState {
  const GetFacialRecognitionWaitingState();

  @override
  List<Object> get props => [];
}

class GetFacialRecognitionSuccessState extends UserManagementState {
  final GetFacialRecognitionModel facialModel;

  const GetFacialRecognitionSuccessState(this.facialModel);

  @override
  List<Object> get props => [facialModel];
}

class GetFacialRecognitionFailureState extends UserManagementState {
  final BaseError error;
  final VoidCallback callback;

  const GetFacialRecognitionFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}

/// Get Behavioral
class GetBehavioralAnalysisWaitingState extends UserManagementState {
  const GetBehavioralAnalysisWaitingState();

  @override
  List<Object> get props => [];
}

class GetBehavioralAnalysisSuccessState extends UserManagementState {
  final GetBehavioralAnalysisModel behavioralModel;

  const GetBehavioralAnalysisSuccessState(this.behavioralModel);

  @override
  List<Object> get props => [behavioralModel];
}

class GetBehavioralAnalysisFailureState extends UserManagementState {
  final BaseError error;
  final VoidCallback callback;

  const GetBehavioralAnalysisFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}

/// Get Human Detection
class GetHumanDetectionWaitingState extends UserManagementState {
  const GetHumanDetectionWaitingState();

  @override
  List<Object> get props => [];
}

class GetHumanDetectionSuccessState extends UserManagementState {
  final GetHumanDetectionModel humanDetectionModel;

  const GetHumanDetectionSuccessState(this.humanDetectionModel);

  @override
  List<Object> get props => [humanDetectionModel];
}

class GetHumanDetectionFailureState extends UserManagementState {
  final BaseError error;
  final VoidCallback callback;

  const GetHumanDetectionFailureState({this.error, this.callback});

  @override
  List<Object> get props => [error, callback];
}
