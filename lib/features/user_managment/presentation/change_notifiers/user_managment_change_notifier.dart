import 'package:flutter/cupertino.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';
import 'package:micropolis_test/features/incident/data/model/subject_model.dart';

class UserManagementChangeNotifier extends ChangeNotifier {
  bool _showAddVehicle = false;
  bool _showAddUser = false;
  bool _showAddAuthorityArea = false;
  bool _showAddArea = false;

  bool get showAddVehicle => _showAddVehicle;

  bool get showAddUser => _showAddUser;

  bool get showAddAuthorityArea => _showAddAuthorityArea;
  bool get showAddArea => _showAddArea;

  set showAddVehicle(bool val) {
    _showAddVehicle = val;
    notifyListeners();
  }

  set showAddUser(bool val) {
    _showAddUser = val;
    notifyListeners();
  }

  set showAddAuthorityArea(bool val) {
    _showAddAuthorityArea = val;
    notifyListeners();
  }

  set showAddArea(bool val) {
    _showAddArea = val;
    notifyListeners();
  }
}
