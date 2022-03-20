import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/localization/flutter_localization.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class AppConfigProvider extends ChangeNotifier {
  Locale _appLocale = Locale(LANG_AR);

  /// This for know if this first time run the application or not
  bool _firstStart = false;

  bool get firstStart => _firstStart;

  setFirstStart(bool val){
    _firstStart = val;
  }

  /// Get current Locale supported
  Locale get appLocal => _appLocale;
  fetchLocale() async {
    var prefs = await SpUtil.getInstance();

    if (prefs.getString(KEY_LANGUAGE) == null) {
      _appLocale = Locale(LANG_AR);
      await prefs.putString(KEY_LANGUAGE, LANG_AR);
      return Null;
    }
    _appLocale = Locale(await prefs.getString(KEY_LANGUAGE));
    return Null;
  }

  Future<void> changeLanguageWithoutRestart(Locale type,BuildContext context) async {
    var prefs = await SpUtil.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale(LANG_AR)) {
      _appLocale = Locale(LANG_AR);
      await prefs.putString(KEY_LANGUAGE, LANG_AR);
    }
    else {
      _appLocale = Locale(LANG_EN);
      await prefs.putString(KEY_LANGUAGE, LANG_EN);
    }
  }
  Future<void> changeLanguage(Locale type,BuildContext context) async {
    setFirstStart(false);
    await changeLanguageWithoutRestart(type,context);
    notifyListeners();
    RestartWidget.restartApp(context);
  }

  Future<void> restartApp(BuildContext context) async{
    notifyListeners();
    RestartWidget.restartApp(context);
  }
}