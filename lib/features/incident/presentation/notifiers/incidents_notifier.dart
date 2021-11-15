import 'package:flutter/cupertino.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';
import 'package:micropolis_test/features/incident/data/model/subject_model.dart';

class IncidentsChangeNotifier extends ChangeNotifier {
  List<IncidentModel> _pinnedIncidents = [];
  SubjectsModel _suspects;

  IncidentModel _currentIncident;

  bool _showSubjectData = false;

  bool _updateHomeIncidentClassifications = false;

  String _newIncidentID;

  int _currentIncidentType = -1;

  int get currentIncidentType => _currentIncidentType;

  String get newIncidentID => _newIncidentID;

  bool get showSubjectData => _showSubjectData;

  bool get updateHomeIncidentClassifications =>
      _updateHomeIncidentClassifications;

  List<IncidentModel> get incidents => _pinnedIncidents;

  SubjectsModel get suspects => _suspects;

  IncidentModel get currentIncident => _currentIncident;

  addIncident(IncidentModel item) {
    _pinnedIncidents.add(item);
    notifyListeners();
  }

  deleteIncident(IncidentModel item) {
    _pinnedIncidents.removeWhere((element) => element.id == item.id);
    notifyListeners();
  }

  set suspects(SubjectsModel val) {
    _suspects = val;
    notifyListeners();
  }

  set newIncidentID(String val) {
    _newIncidentID = val;
    notifyListeners();
  }

  set showSubjectData(bool val) {
    _showSubjectData = val;
    notifyListeners();
  }

  set currentIncident(IncidentModel val) {
    _currentIncident = val;
    notifyListeners();
  }

  set currentIncidentType(int val) {
    _currentIncidentType = val;
    notifyListeners();
  }

  setCurrentIncidentWithoutNotifications(IncidentModel val) {
    _currentIncident = val;
  }

  set updateHomeIncidentClassifications(bool val) {
    _updateHomeIncidentClassifications = val;
    notifyListeners();

    Future.delayed(Duration(milliseconds: 100))
        .then((value) => _updateHomeIncidentClassifications = false);
  }
}
