import 'package:micropolis_test/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'core/Common/appConfig.dart';
import 'core/localization/localization_provider.dart';

main() async {
  final _appLanguage = AppConfigProvider();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);


  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  // Init Language.
  setupLocator();

  await _appLanguage.fetchLocale();
  appConfig.initVersion();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    App(
      appLanguage: _appLanguage,
    ),
  );
}
