import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/features/user_managment/data/datasource/usermanagment_datasource.dart';
import 'package:micropolis_test/features/user_managment/data/models/create_user_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/users_list_model.dart';

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
    }
  }
}
