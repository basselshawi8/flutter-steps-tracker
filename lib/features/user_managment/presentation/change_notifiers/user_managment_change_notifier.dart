import 'package:flutter/cupertino.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';
import 'package:micropolis_test/features/incident/data/model/subject_model.dart';

class UserManagementChangeNotifier extends ChangeNotifier {
  bool _showAddVehicle = false;

  bool get showAddVehicle => _showAddVehicle;

  set showAddVehicle(bool val) {
    _showAddVehicle = val;
    notifyListeners();
  }
}
