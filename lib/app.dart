import 'dart:async';

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

import 'features/restaurants/presentation/bloc/restaurants_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/restaurants/presentation/screen/restaurants_screen.dart';
import 'navigation_service.dart';
import 'service_locator.dart';
import 'package:uni_links/uni_links.dart';

class App extends StatefulWidget {
  final AppConfigProvider? appLanguage;

  const App({Key? key, this.appLanguage}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  StreamSubscription? _sub;

  Future<void> initUniLinks() async {
    // ... check initialLink

    // Attach a listener to the stream
    _sub = linkStream.listen((String? link) {
      // Parse the link and warn the user, if it is not correct
      print(link);
      var context =
          locator<NavigationService>().getNavigationKey.currentContext;
      if (context != null)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Container(
          height: 40.h,
          child: Center(
            child: Text(link ?? "no link"),
          ),
        )));
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });

    // NOTE: Don't forget to call _sub.cancel() in dispose()
  }

  @override
  void initState() {
    initUniLinks();
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
                    secondary: CoreStyle.operationBlackColor,
                    primary: CoreStyle.operationGreenContent,
                    primaryVariant: CoreStyle.operationGreenContent,
                    secondaryVariant: CoreStyle.operationRose2Color,
                    surface: CoreStyle.operationBorder3Color,
                    background: CoreStyle.operationGreenContent,
                    onBackground: CoreStyle.primaryDarkValue,
                    onPrimary: CoreStyle.darkRedColor,
                    onSecondary: CoreStyle.operationGreenContent,
                    onSurface: CoreStyle.White400,
                    onError: CoreStyle.operationLightTextColor,
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
              //home: PolygonDrawer())
              home: RestaurantsScreen()),
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
