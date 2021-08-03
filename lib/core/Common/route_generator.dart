import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:micropolis_test/features/incident/presentation/screens/incidents_screen.dart';
import 'package:micropolis_test/features/map/presentation/screen/robot_location_map.dart';
import 'package:micropolis_test/features/restaurants/presentation/screen/menu_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    var pathName = settings.name.split("?").first;
    switch (pathName) {
      case MenuScreen.routeName:
        if (args is Map) {
          return CupertinoPageRoute(
              builder: (_) => MenuScreen(
                    restaurant: args["restaurant"],
                  ),
              settings: settings);
        }
        return _errorRoute();
      case RobotLocationMap.routeName:
        return CupertinoPageRoute(
            builder: (_) => RobotLocationMap(), settings: settings);
      case IncidentsScreen.routeName:
        return CupertinoPageRoute(
            builder: (_) => IncidentsScreen(
                  location:
                      args is Map<String, dynamic> ? args["location"] : null,
                  type: settings.name.split("?type=").length > 1
                      ? settings.name.split("?type=")[1]
                      : null,
                ),
            settings: settings);

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            key: new GlobalKey(),
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class SlideLeftRoute extends PageRouteBuilder {
  final Widget page;

  SlideLeftRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            key: new GlobalKey(),
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class ScaleRoute extends PageRouteBuilder {
  final Widget page;

  ScaleRoute({this.page})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return page;
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return new ScaleTransition(
            scale: new Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Interval(
                  0.00,
                  0.50,
                  curve: Curves.linear,
                ),
              ),
            ),
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 1.5,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Interval(
                    0.50,
                    1.00,
                    curve: Curves.linear,
                  ),
                ),
              ),
              child: child,
            ),
          );
        });
}
