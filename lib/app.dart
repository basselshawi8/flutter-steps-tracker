
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:micropolis_test/features/home/presentation/bloc/steps_bloc.dart';
import 'package:micropolis_test/features/home/presentation/presentation/screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'core/Common/Common.dart';
import 'core/Common/route_generator.dart';
import 'core/constants.dart';
import 'core/localization/flutter_localization.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'navigation_service.dart';
import 'service_locator.dart';

class App extends StatefulWidget {
  final AppConfigProvider? appLanguage;

  const App({Key? key, this.appLanguage}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: widget.appLanguage,
        ),
        BlocProvider(
          create: (_) => StepsBloc(),
          lazy: true,
        ),
      ],
      child: Consumer<AppConfigProvider>(builder: (_, provider, __) {
        return ScreenUtilInit(
          designSize: Size(320, 640),
          builder: () => MaterialApp(
              debugShowCheckedModeBanner: false,
              // Will use While create notification
              // navigatorKey: locator<GlobalK>().getNewNavigationKey,
              navigatorKey: locator<NavigationService>().getNavigationKey,
              //Provider.of<Profile>(context,listen: false).navigationKey,
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute: "/",
              title: "Steps Counter",
              themeMode: ThemeMode.light,
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  color: CoreStyle.primaryTheme,
                ),
                fontFamily: provider.appLocal.languageCode == LANG_EN
                    ? GoogleFonts.poppins(fontWeight: FontWeight.w400)
                        .fontFamily
                    : GoogleFonts.cairo().fontFamily,
                primaryColor: CoreStyle.primaryTheme,
                accentColor: CoreStyle.accentTheme,
                snackBarTheme: const SnackBarThemeData(
                  actionTextColor: CoreStyle.white,
                  backgroundColor: CoreStyle.primaryTheme,
                  behavior: SnackBarBehavior.fixed,
                  elevation: 5.0,
                ),
                colorScheme: ColorScheme(
                    secondary: CoreStyle.operationBlackColor,
                    primary: CoreStyle.tchpinOrangeColor,
                    surface: CoreStyle.operationBorder3Color,
                    background: CoreStyle.tchpinOrangeColor,
                    onBackground: CoreStyle.primaryDarkValue,
                    onPrimary: CoreStyle.darkRedColor,
                    onSecondary: CoreStyle.tchpinOrangeColor,
                    onSurface: CoreStyle.White400,
                    onError: CoreStyle.operationLightTextColor,
                    brightness: Brightness.light,
                    error: CoreStyle.tchpinOrangeColor),
                scaffoldBackgroundColor: CoreStyle.backGroundColor,
              ),
              supportedLocales: [
                // first
                const Locale(LANG_EN),
                // last
              ],
              // Returns a locale which will be used by the app
              localeResolutionCallback: (locale, supportedLocales) {
                if (provider.firstStart == true) {
                  // Check if the current device locale is supported
                  for (var supportedLocale in supportedLocales) {
                    if (locale != null &&
                        supportedLocale.languageCode == locale.languageCode) {
                      provider.changeLanguageWithoutRestart(
                          Locale(locale.languageCode), context);
                      // set _firstStart false
                      provider.setFirstStart(false);
                      return supportedLocale;
                    }
                  }
                  // If the locale of the device is not supported, use the first one
                  // from the list (English, in this case).
                  provider.changeLanguageWithoutRestart(
                      supportedLocales.first, context);
                  return supportedLocales.first;
                } else
                  return null;
              },
              locale: provider.firstStart == true ? null : provider.appLocal,
              // These delegates make sure that the localization data for the proper language is loaded
              localizationsDelegates: [
                // A class which loads the translations from JSON files
                Translations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              home: SplashScreen()),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<StepsBloc>(context).close();
  }
}
