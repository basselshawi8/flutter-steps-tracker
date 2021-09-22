import 'dart:convert';
import 'package:micropolis_test/core/params/base_params.dart';

class CreateUserParam extends BaseParams {
  final List<String> rolesIds;
  final String name;
  final String surname;
  final String username;
  final String email;
  final String password;

  CreateUserParam(this.rolesIds, this.name, this.surname, this.username,
      this.email, this.password);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "rolesIds": rolesIds,
        "name": name,
        "surname": surname,
        "username": username,
        "email": email,
        "password": password
      };
}
