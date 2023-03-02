import 'package:flutter/material.dart';
import 'package:weather_app/ui/pages/search_page/search_page.dart';
import 'package:weather_app/ui/routes/App_routes.dart';

import '../pages/Eror_page/error_page.dart';
import '../pages/home_page/home_page.dart';
import '../pages/splesh_scrin/splesh_scrin.dart';

class AppNavigator {
  static String initRoute = AppRoutes.home;
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.home: (_) => const AnimatedScreen(),
      AppRoutes.search: (_) => const SearchPage(),
    };
  }

  static Route generate(RouteSettings settings) {
    final routeSettings = RouteSettings(
      name: '/404',
      arguments: settings.arguments,
    );
    return MaterialPageRoute(
      builder: (_) => const ErrorPage(),
      settings: routeSettings,
    );
  }
}
