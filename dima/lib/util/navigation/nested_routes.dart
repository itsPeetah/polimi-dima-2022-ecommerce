import 'package:flutter/material.dart';
import 'package:dima/pages/404.dart';
import 'package:dima/pages/fork.dart';
import 'package:dima/pages/hello.dart';

class NestedNavigatorRoutes {
  static const String root = "/";
  static const String home = "/home";
  static const String map = "/map";
  static const String cart = "/cart";
  static const String profile = "/profile";
  static const String product = "/product";
}

class NestedNavigatorRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NestedNavigatorRoutes.home:
        return MaterialPageRoute(
          // builder: (_) => const HelloPage(title: "Home"),
          builder: (_) => const ForkPage(
            route1: "/home",
            route2: "/map",
            title: "Home",
          ),
        );
      case NestedNavigatorRoutes.map:
        return MaterialPageRoute(
          // builder: (_) => const HelloPage(title: "Map"),
          builder: (_) => const ForkPage(
            route1: "/cart",
            route2: "/home",
            title: "Map",
          ),
        );
      case NestedNavigatorRoutes.cart:
        return MaterialPageRoute(
          // builder: (_) => const HelloPage(title: "Cart"),
          builder: (_) => const ForkPage(
            route1: "/profile",
            route2: "/map",
            title: "Cart",
          ),
        );
      case NestedNavigatorRoutes.profile:
        return MaterialPageRoute(
          // builder: (_) => const HelloPage(title: "Profile"),
          builder: (_) => const ForkPage(
            route1: "/map",
            route2: "/cart",
            title: "Profile",
          ),
        );
      case "/":
        return MaterialPageRoute(
            builder: (_) => const HelloPage(
                  title: "You shouldn't be here...",
                ));
      default:
        return MaterialPageRoute(builder: (_) => const PageNotFound());
    }
  }

  static Route? generateHomeRoute(RouteSettings settings) {
    final String name = _replaceRoot(settings.name, NestedNavigatorRoutes.home);
    RouteSettings newSettings =
        RouteSettings(name: name, arguments: settings.arguments);
    return generateRoute(newSettings);
  }

  static Route? generateMapRoute(RouteSettings settings) {
    final String name = _replaceRoot(settings.name, NestedNavigatorRoutes.map);
    RouteSettings newSettings =
        RouteSettings(name: name, arguments: settings.arguments);
    return generateRoute(newSettings);
  }

  static Route? generateCartRoute(RouteSettings settings) {
    final String name = _replaceRoot(settings.name, NestedNavigatorRoutes.cart);
    RouteSettings newSettings =
        RouteSettings(name: name, arguments: settings.arguments);
    return generateRoute(newSettings);
  }

  static Route? generateProfileRoute(RouteSettings settings) {
    final String name =
        _replaceRoot(settings.name, NestedNavigatorRoutes.profile);
    RouteSettings newSettings =
        RouteSettings(name: name, arguments: settings.arguments);
    return generateRoute(newSettings);
  }

  static String _replaceRoot(String? name, String replacement) {
    String res = name == NestedNavigatorRoutes.root ? replacement : name!;
    return res;
  }
}
