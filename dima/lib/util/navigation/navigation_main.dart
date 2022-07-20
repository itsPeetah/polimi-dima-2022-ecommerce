import 'package:dima/model/product.dart';
import 'package:dima/pages/authentication/register.dart';
import 'package:dima/pages/authentication/signin.dart';
import 'package:dima/pages/payment.dart';
import 'package:dima/pages/thankspage.dart';
import 'package:flutter/material.dart';
import 'package:dima/widgets/navigation/main_navigation.dart';
import 'package:dima/pages/misc/404.dart';

import '../../pages/paymentdetails.dart';

class MainNavigator {
  static final mainNavigatorKey = GlobalKey<NavigatorState>();

  static Future<void> push(String route, {arguments}) {
    if (route[0] != "/") route = "/" + route;
    final rs = RouteSettings(name: route, arguments: arguments);
    Route? r = MainNavigatorRouter.generateRoute(rs);
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
  static const String bankDetails = "/bankDetails";
  static const String thankYouPage = "/thankyou";
  static const String signin = "/signin";
  static const String register = "/register";
}

// Generate routes for the main navigation
class MainNavigatorRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRoutes.root:
        return MaterialPageRoute(builder: (_) => const MainNavigation());
      case MainNavigationRoutes.signin:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case MainNavigationRoutes.register:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case MainNavigationRoutes.checkout:
        Object? showPage;
        if (settings.arguments != null) {
          Map arguments = settings.arguments as Map<String, Object?>;
          showPage = arguments['show'] as Object?;
        }
        showPage ??= true;
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: PaymentPage(
              showPage: showPage as bool,
            ),
          ),
        );
      case MainNavigationRoutes.bankDetails:
        Map args = settings.arguments as Map<String, String>;
        String name = args['name'];
        String location = args['location'];
        String? phone = args['phone'];
        String price = args['price'].toString();
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: PaymentDetailsPage(
                name: name, location: location, phone: phone, price: price),
          ),
        );
      case MainNavigationRoutes.thankYouPage:
        Map args = settings.arguments as Map<String, dynamic>;
        List<Product> lop = args["listOfProducts"];
        String location = args["location"];
        String price = args["price"];
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: ThanksPage(
                listOfProducts: lop, location: location, price: price),
          ),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(body: PageNotFound()));
    }
  }
}
