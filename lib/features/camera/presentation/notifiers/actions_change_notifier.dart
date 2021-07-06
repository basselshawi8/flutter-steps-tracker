import 'package:flutter/material.dart';

class ActionsChangeNotifier extends ChangeNotifier {
  bool _showPinnedActions = false;

  bool get showPinnedActions => _showPinnedActions;

  set showPinnedActions(bool val) {
    _showPinnedActions = val;
    notifyListeners();
  }
}
