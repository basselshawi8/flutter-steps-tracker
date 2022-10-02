import 'dart:io';

import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform_device_id/platform_device_id.dart';

import '../constants.dart';
import 'shared_preference.dart';

// This class it contain tow functions
// for get device info
// and for get and set language and check if has token or not
class AppConfig {
  static String? lang;

  int? os;
  String? currentVersion;
  String? buildNumber;
  String? appName;
  String? deviceUniqueIdentifier;

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

    try {
      deviceUniqueIdentifier = await PlatformDeviceId.getDeviceId;
      print(deviceUniqueIdentifier);
    } on PlatformException {
      deviceUniqueIdentifier = 'Failed to get deviceId.';
    }
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
    return lang!;
  }
}

AppConfig appConfig = AppConfig();
