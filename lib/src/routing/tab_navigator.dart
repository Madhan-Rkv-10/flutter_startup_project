import 'package:flutter/material.dart';
import 'package:startup_flutter_page_view/src/features/secondpage/second_page.dart';

import '../features/home/home.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String homeScreen = "/home_screen";
  static const String secondScreen = '/second_screen';

  static final initialRoutes = [
    homeScreen,
    secondScreen,
    secondScreen,
  ];
}

class TabNavigator extends StatelessWidget {
  const TabNavigator({Key? key, this.navigatorKey, this.position})
      : super(key: key);
  final GlobalKey<NavigatorState>? navigatorKey;
  final int? position;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.initialRoutes[position!],
      onGenerateRoute: (routeSettings) {
        debugPrint('Route Settings Name ${routeSettings.name}');
        final routeBuilders1 = _routeBuilders(context,
            data: routeSettings.arguments as Map<String, dynamic>?);
        return MaterialPageRoute(
            builder: (context) => routeBuilders1[
                routeSettings.name == TabNavigatorRoutes.root
                    ? TabNavigatorRoutes.initialRoutes[position!]
                    : routeSettings.name]!(context),
            settings: routeSettings);
      },
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {Map<String, dynamic>? data}) {
    return {
      TabNavigatorRoutes.homeScreen: (context) => const HomeScreen(),
      TabNavigatorRoutes.secondScreen: (context) => const SecondPage(),
    };
  }
}
