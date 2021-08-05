import 'package:flutter/cupertino.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';

class IncidentsChangeNotifier extends ChangeNotifier {
  List<IncidentsDatum> _pinnedIncidents = [];

  IncidentsDatum _currentIncident;

  String _imageCap;

  String _imageMatch;

  String get imageCap => _imageCap;

  String get imageMatch => _imageMatch;

  List<IncidentsDatum> get incidents => _pinnedIncidents;

  IncidentsDatum get currentIncident => _currentIncident;

  addIncident(IncidentsDatum item) {
    _pinnedIncidents.add(item);
    notifyListeners();
  }

  deleteIncident(IncidentsDatum item) {
    _pinnedIncidents.removeWhere((element) => element.id == item.id);
    notifyListeners();
  }

  set imageCap(String val) {
    _imageCap = val;
    notifyListeners();
  }

  set imageMatch(String val) {
    _imageMatch = val;
    notifyListeners();
  }

  set currentIncident(IncidentsDatum val) {
    _currentIncident = val;
    notifyListeners();
  }
}
