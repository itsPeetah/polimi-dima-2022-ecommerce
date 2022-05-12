import 'package:dima/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:dima/components/navigation/main_navigation.dart';
import 'package:dima/pages/404.dart';

class MainNavigator {
  static final mainNavigatorKey = GlobalKey<NavigatorState>();

  static void push(String route) {
    if (route[0] != "/") route = "/" + route;
    final rs = RouteSettings(name: route);
    final r = MainNavigatorRouter.generateRoute(rs);
    mainNavigatorKey.currentState!.push(r!);
  }
}

class MainNavigationRoutes {
  static const String root = "/";
  static const String checkout = "/checkout";
  static const String payment = "/payment";
  static const String checkoutResult = "/checkoutResult";
  static const String signin = "/signin";
  static const String register = "/register";
}

// Generate routes for the main navigation
class MainNavigatorRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /* Put here the cases for checkout, payment... */
      case MainNavigationRoutes.root:
        return MaterialPageRoute(builder: (_) => const MainNavigation());
      case MainNavigationRoutes.signin:
        return MaterialPageRoute(builder: (_) => SignInPage());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(body: PageNotFound()));
      // return MaterialPageRoute(
      //     builder: (_) => const Scaffold(body: FoobarPage()));
    }
  }
}
