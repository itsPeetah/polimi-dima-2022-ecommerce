import 'package:dima/pages/authentication/register.dart';
import 'package:dima/pages/authentication/signin.dart';
import 'package:flutter/material.dart';
import 'package:dima/widgets/navigation/main_navigation.dart';
import 'package:dima/pages/misc/404.dart';

class MainNavigator {
  static final mainNavigatorKey = GlobalKey<NavigatorState>();

  static Future<void> push(String route) {
    if (route[0] != "/") route = "/" + route;
    final rs = RouteSettings(name: route);
    final r = MainNavigatorRouter.generateRoute(rs);
    return mainNavigatorKey.currentState!.push(r!);
  }

  static void pop() {
    mainNavigatorKey.currentState!.pop();
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
      case MainNavigationRoutes.register:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(body: PageNotFound()));
      // return MaterialPageRoute(
      //     builder: (_) => const Scaffold(body: FoobarPage()));
    }
  }
}
