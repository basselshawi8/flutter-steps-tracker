import 'package:flutter/material.dart';

class ActionsChangeNotifier extends ChangeNotifier {
  bool _showPinnedActions = false;

  bool _showIncidentsPanel = false;

  bool get showPinnedActions => _showPinnedActions;

  bool get showIncidentsPanel => _showIncidentsPanel;

  set showPinnedActions(bool val) {
    _showPinnedActions = val;
    notifyListeners();
  }

  set showIncidentsPanel(bool val) {
    _showIncidentsPanel = val;
    notifyListeners();
  }
}
