import 'package:flutter/material.dart';
import 'package:dima/components/navigation/main_navigation.dart';
import 'package:dima/pages/404.dart';

class MainNavigator {
  static final mainNavigatorKey = GlobalKey<NavigatorState>();
}

class MainNavigationRoutes {
  static const String root = "/";
  static const String checkout = "/checkout";
  static const String payment = "/payment";
  static const String checkoutResult = "/checkoutResult";
  static const String signin = "/signin";
}

// Generate routes for the main navigation
class MainNavigatorRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /* Put here the cases for checkout, payment... */
      case MainNavigationRoutes.root:
        return MaterialPageRoute(builder: (_) => const MainNavigation());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(body: PageNotFound()));
      // return MaterialPageRoute(
      //     builder: (_) => const Scaffold(body: FoobarPage()));
    }
  }
}
