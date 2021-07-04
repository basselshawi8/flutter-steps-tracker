import 'dart:io';

import 'package:package_info/package_info.dart';

import '../constants.dart';
import 'shared_preference.dart';

// This class it contain tow functions
// for get device info
// and for get and set language and check if has token or not
class AppConfig {
  static String lang;

  int os;
  String currentVersion;
  String buildNumber;
  String appName;

  initVersion() async {
    /// get OS
    if (Platform.isIOS) {
      os = 2;
    }
    if (Platform.isAndroid) {
      os = 1;
    }

    /// get version
    final packageInfo = await PackageInfo.fromPlatform();
    currentVersion = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    appName = packageInfo.appName;
  }




  // get current language from shared pref
  Future<String> currentLanguage() async {
    final prefs = await SpUtil.getInstance();

    try {
      lang = await prefs.getString(KEY_LANGUAGE);
      if (lang == 'ckb') {
        lang = 'ku';
      }
    } catch (e) {
      lang = LANG_AR;
    }
    return lang;
  }
}

AppConfig appConfig = AppConfig();
