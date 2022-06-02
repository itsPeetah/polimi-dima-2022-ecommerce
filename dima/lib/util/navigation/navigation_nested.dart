import 'package:dima/pages/cart.dart';
import 'package:dima/pages/home.dart';
import 'package:dima/pages/map.dart';
import 'package:dima/pages/product.dart';
import 'package:dima/pages/profile.dart';
import 'package:dima/util/navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:dima/pages/misc/404.dart';
import 'package:dima/pages/misc/hello.dart';

class SecondaryNavigator {
  static final homeNavigatorKey = GlobalKey<NavigatorState>();
  static final mapNavigatorKey = GlobalKey<NavigatorState>();
  static final cartNavigatorKey = GlobalKey<NavigatorState>();
  static final profileNavigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> keyOf(TabItem navigatorTab) {
    switch (navigatorTab) {
      case TabItem.home:
        return homeNavigatorKey;
      case TabItem.map:
        return mapNavigatorKey;
      case TabItem.cart:
        return cartNavigatorKey;
      case TabItem.profile:
        return profileNavigatorKey;
    }
  }

  static NavigatorState of(TabItem navigatorTab) {
    switch (navigatorTab) {
      case TabItem.home:
        return homeNavigatorKey.currentState!;
      case TabItem.map:
        return mapNavigatorKey.currentState!;
      case TabItem.cart:
        return cartNavigatorKey.currentState!;
      case TabItem.profile:
        return profileNavigatorKey.currentState!;
    }
  }

  static void push(BuildContext context, String routeName,
      {Object? routeArgs}) {
    final RouteSettings rs =
        RouteSettings(name: routeName, arguments: routeArgs);
    final Route? r = NestedNavigatorRouter.generateRoute(rs);
    Navigator.push(context, r!);
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}

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
          builder: (_) => const HomePage(),
        );
      case NestedNavigatorRoutes.map:
        return MaterialPageRoute(
          builder: (_) => const MapPage(),
        );
      case NestedNavigatorRoutes.cart:
        return MaterialPageRoute(
          builder: (_) => const CartPage(),
        );
      case NestedNavigatorRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfilePage(),
        );
      case NestedNavigatorRoutes.product:
        // TODO Null check for id arg
        Map args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) => ProductPage(productId: args["id"]));
      case "/":
        return MaterialPageRoute(
          builder: (_) => const HelloPage(
            title: "You shouldn't be here...",
          ),
        );
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
