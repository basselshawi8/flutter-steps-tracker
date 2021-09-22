import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/features/user_managment/data/models/create_user_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/users_list_model.dart';

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
