import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/user_managment/data/models/get_facial_model.dart';
import 'package:micropolis_test/features/user_managment/data/params/create_behavioral_param.dart';
import 'package:micropolis_test/features/user_managment/data/params/create_facial_param.dart';
import 'package:micropolis_test/features/user_managment/data/params/create_human_param.dart';
import 'package:micropolis_test/features/user_managment/data/params/create_user_param.dart';
import 'package:micropolis_test/features/user_managment/data/params/get_vehicle_attr_param.dart';

@immutable
abstract class UserManagementEvent extends Equatable {
  const UserManagementEvent();
}

class CreateUser extends UserManagementEvent {
  final CreateUserParam param;

  CreateUser(this.param);

  @override
  List<Object> get props => [this.param];
}

class GetUsers extends UserManagementEvent {
  final NoParams param;

  GetUsers(this.param);

  @override
  List<Object> get props => [this.param];
}

class GetRoles extends UserManagementEvent {
  final NoParams param;

  GetRoles(this.param);

  @override
  List<Object> get props => [this.param];
}

class GetVehicles extends UserManagementEvent {
  final NoParams param;

  GetVehicles(this.param);

  @override
  List<Object> get props => [this.param];
}

class CreateBehavioralAnalysis extends UserManagementEvent {
  final CreateBehavioralParam param;

  CreateBehavioralAnalysis(this.param);

  @override
  List<Object> get props => [this.param];
}

class CreateFacialRecognition extends UserManagementEvent {
  final CreateFacialParam param;

  CreateFacialRecognition(this.param);

  @override
  List<Object> get props => [this.param];
}

class CreateHumanDetection extends UserManagementEvent {
  final CreateHumanDetectionParam param;

  CreateHumanDetection(this.param);

  @override
  List<Object> get props => [this.param];
}

class GetFacial extends UserManagementEvent {
  final GetVechileParam param;

  GetFacial(this.param);

  @override
  List<Object> get props => [this.param];
}

class GetBehavioral extends UserManagementEvent {
  final GetVechileParam param;

  GetBehavioral(this.param);

  @override
  List<Object> get props => [this.param];
}

class GetHumanDetection extends UserManagementEvent {
  final GetVechileParam param;

  GetHumanDetection(this.param);

  @override
  List<Object> get props => [this.param];
}
