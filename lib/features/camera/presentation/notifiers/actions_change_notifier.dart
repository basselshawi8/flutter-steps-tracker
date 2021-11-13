import 'package:flutter/material.dart';

class ActionsChangeNotifier extends ChangeNotifier {
  bool _showPinnedActions = false;

  bool _showIncidentsPanel = false;
  bool _rcMode = false;

  bool get showPinnedActions => _showPinnedActions;

  bool get showIncidentsPanel => _showIncidentsPanel;

  bool get rcMode => _rcMode;

  set showPinnedActions(bool val) {
    _showPinnedActions = val;
    notifyListeners();
  }

  set showIncidentsPanel(bool val) {
    _showIncidentsPanel = val;
    notifyListeners();
  }

  set rcMode(bool val) {
    _rcMode = val;
    notifyListeners();
  }
}
