import 'package:flutter/material.dart';

class NavigationService {
  final _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get getNavigationKey => _navigationKey;

  pop() {
    return _navigationKey.currentState.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState.pushNamed(routeName, arguments: arguments);
  }
}