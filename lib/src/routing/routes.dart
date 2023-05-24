import 'package:startup_flutter_page_view/src/features/home/home.dart';
import 'package:startup_flutter_page_view/src/features/main_page.dart';
import 'package:startup_flutter_page_view/src/features/secondpage/second_page.dart';

import '../../src/routing/route_constants.dart';
import 'package:flutter/material.dart';

import '../features/splash/screen/splash_screen.dart';

class RouteManager {
  MaterialPageRoute<dynamic> route(RouteSettings settings) {
    dynamic data = settings.arguments != null ? settings.arguments ?? {} : {};

    switch (settings.name) {
      case RouteConstants.splashScreen:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteConstants.splashScreen),
            builder: (context) => const SplashScreen());
      case RouteConstants.mainScreen:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteConstants.mainScreen),
            builder: (context) => MainScreen(
                  initPage: data['initPage'],
                ));
      case RouteConstants.homeScreen:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteConstants.homeScreen),
            builder: (context) => const HomeScreen());
      case RouteConstants.secondScreen:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteConstants.secondScreen),
            builder: (context) => const SecondPage());
      default:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteConstants.splashScreen),
            builder: (context) => const SplashScreen());
    }
  }
}

RouteFactory get onGenerateRoute => RouteManager().route;
