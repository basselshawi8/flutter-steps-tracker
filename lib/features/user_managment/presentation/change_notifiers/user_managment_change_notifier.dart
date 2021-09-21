import 'package:flutter/cupertino.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';
import 'package:micropolis_test/features/incident/data/model/subject_model.dart';

class UserManagementChangeNotifier extends ChangeNotifier {
  bool _showAddVehicle = false;
  bool _showAddUser = false;
  bool _showAddPolygon = false;

  bool get showAddVehicle => _showAddVehicle;

  bool get showAddUser => _showAddUser;

  bool get showAddPolygon => _showAddPolygon;

  set showAddVehicle(bool val) {
    _showAddVehicle = val;
    notifyListeners();
  }

  set showAddUser(bool val) {
    _showAddUser = val;
    notifyListeners();
  }

  set showAddPolygon(bool val) {
    _showAddPolygon = val;
    notifyListeners();
  }
}
