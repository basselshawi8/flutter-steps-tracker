import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/user_managment/data/params/create_user_param.dart';

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
