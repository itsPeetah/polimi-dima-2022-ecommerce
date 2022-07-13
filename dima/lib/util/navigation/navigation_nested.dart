import 'package:dima/pages/app_info.dart';
import 'package:dima/pages/cart.dart';
import 'package:dima/pages/favorites.dart';
import 'package:dima/pages/home.dart';
import 'package:dima/pages/map.dart';
import 'package:dima/pages/payment.dart';
import 'package:dima/pages/paymentdetails.dart';
import 'package:dima/pages/product.dart';
import 'package:dima/pages/profile.dart';
import 'package:dima/pages/search_products.dart';
import 'package:dima/pages/shopPage.dart';
import 'package:dima/util/navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:dima/pages/misc/404.dart';
import 'package:dima/pages/misc/hello.dart';

import '../../model/product.dart';
import '../../pages/history.dart';
import '../../pages/thankspage.dart';

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
  static const String appInfo = "/appInfo";
  static const String search = "/search";
  // PAYMENT PAGES
  static const String checkout = "/checkout";
  static const String thankyoupage = "/thankyoupage";
  static const String bankDetails = "/bankDetails";
  // Shop Page
  static const String shop = '/shop';
  // Purchase History and favorites
  static const String favorites = '/favorites';
  static const String history = '/history';
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
        Map args = settings.arguments as Map<String, String>;
        final String argument = args["id"] as String;
        return MaterialPageRoute(
            builder: (_) => ProductPage(productId: argument));
      case NestedNavigatorRoutes.checkout:
        Object? showPage;
        if (settings.arguments != null) {
          Map arguments = settings.arguments as Map<String, Object?>;
          showPage = arguments['show'] as Object?;
        }
        // if showPage is null, it sets it to true
        showPage ??= true;
        return MaterialPageRoute(
            builder: (_) => PaymentPage(
                  showPage: showPage as bool,
                ));
      case NestedNavigatorRoutes.bankDetails:
        Map args = settings.arguments as Map<String, String>;
        String name = args['name'];
        String location = args['location'];
        String? phone = args['phone'];
        String price = args['price'].toString();
        return MaterialPageRoute(
            builder: (_) => PaymentDetailsPage(
                name: name, location: location, phone: phone, price: price));
      case NestedNavigatorRoutes.thankyoupage:
        Map args = settings.arguments as Map<String, dynamic>;
        List<Product> products = args['listOfProducts'];
        String location = args['location'].toString();
        String price = args['price'].toString();
        return MaterialPageRoute(
            builder: (_) => ThanksPage(
                  listOfProducts: products,
                  location: location,
                  price: price,
                ));
      case NestedNavigatorRoutes.shop:
        Map args = settings.arguments as Map<String, dynamic>;
        String shopId = args['shopId'];
        return MaterialPageRoute(builder: (_) => ShopPage(shopId: shopId));
      case NestedNavigatorRoutes.history:
        return MaterialPageRoute(builder: (_) => const HistoryPage());
      case NestedNavigatorRoutes.favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesPage());
      case NestedNavigatorRoutes.appInfo:
        return MaterialPageRoute(builder: (_) => const AppInfoPage());
      case NestedNavigatorRoutes.search:
        return MaterialPageRoute(builder: (_) => const ProductSearchPage());
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
