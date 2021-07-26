import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'core/Common/Common.dart';
import 'core/Common/route_generator.dart';
import 'core/constants.dart';
import 'core/localization/flutter_localization.dart';

import 'features/camera/presentation/notifiers/actions_change_notifier.dart';
import 'features/camera/presentation/screens/main_window_screen.dart';
import 'features/restaurants/presentation/bloc/restaurants_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'navigation_service.dart';
import 'service_locator.dart';

class App extends StatefulWidget {
  final AppConfigProvider appLanguage;

  const App({Key key, this.appLanguage}) : super(key: key);

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
        ChangeNotifierProvider.value(
          value: ActionsChangeNotifier(),
        ),
        BlocProvider(
          create: (_) => RestaurantsBloc(),
          lazy: true,
        ),
      ],
      child: Consumer<AppConfigProvider>(builder: (_, provider, __) {
        return ScreenUtilInit(
          designSize: Size(1920, 1080),
          builder: () => MaterialApp(
              debugShowCheckedModeBanner: false,
              // Will use While create notification
              // navigatorKey: locator<GlobalK>().getNewNavigationKey,
              navigatorKey: locator<NavigationService>().getNavigationKey,
              //Provider.of<Profile>(context,listen: false).navigationKey,
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute: "/",
              title: "Operation Room",
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
                    secondary: CoreStyle.operationGreenContent,
                    primary: CoreStyle.operationGreenContent,
                    primaryVariant: CoreStyle.operationGreenContent,
                    secondaryVariant: CoreStyle.operationGreenContent,
                    surface: CoreStyle.operationGreenContent,
                    background: CoreStyle.operationGreenContent,
                    onBackground: CoreStyle.operationGreenContent,
                    onPrimary: CoreStyle.operationGreenContent,
                    onSecondary: CoreStyle.operationGreenContent,
                    onSurface: CoreStyle.operationGreenContent,
                    onError: CoreStyle.operationGreenContent,
                    brightness: Brightness.light,
                    error: CoreStyle.operationGreenContent),
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
                    if (supportedLocale.languageCode == locale.languageCode) {
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
              //home: SplashScreen()));
              home: MainWindowScreen()),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<RestaurantsBloc>(context).close();
  }
}
