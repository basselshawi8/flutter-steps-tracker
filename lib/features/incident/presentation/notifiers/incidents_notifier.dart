import 'package:flutter/cupertino.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';
import 'package:micropolis_test/features/incident/data/model/subject_model.dart';

class IncidentsChangeNotifier extends ChangeNotifier {
  List<IncidentsDatum> _pinnedIncidents = [];
  SubjectsModel _suspects;

  IncidentsDatum _currentIncident;

  bool _showSubjectData = false;

  bool _updateHomeIncidentClassifications = false;

  String _imageCap;

  String _imageMatch;

  String _newIncidentID;

  String get imageCap => _imageCap;

  String get newIncidentID => _newIncidentID;

  String get imageMatch => _imageMatch;

  bool get showSubjectData => _showSubjectData;

  bool get updateHomeIncidentClassifications =>
      _updateHomeIncidentClassifications;

  List<IncidentsDatum> get incidents => _pinnedIncidents;

  SubjectsModel get suspects => _suspects;

  IncidentsDatum get currentIncident => _currentIncident;

  addIncident(IncidentsDatum item) {
    _pinnedIncidents.add(item);
    notifyListeners();
  }

  deleteIncident(IncidentsDatum item) {
    _pinnedIncidents.removeWhere((element) => element.id == item.id);
    notifyListeners();
  }

  set suspects(SubjectsModel val) {
    _suspects = val;
    notifyListeners();
  }

  set imageCap(String val) {
    _imageCap = val;
    notifyListeners();
  }

  set newIncidentID(String val) {
    _newIncidentID = val;
    notifyListeners();
  }

  set imageMatch(String val) {
    _imageMatch = val;
    notifyListeners();
  }

  set showSubjectData(bool val) {
    _showSubjectData = val;
    notifyListeners();
  }

  set currentIncident(IncidentsDatum val) {
    _currentIncident = val;
    notifyListeners();
  }

  set updateHomeIncidentClassifications(bool val) {
    _updateHomeIncidentClassifications = val;
    notifyListeners();

    Future.delayed(Duration(milliseconds: 100))
        .then((value) => _updateHomeIncidentClassifications = false);
  }
}