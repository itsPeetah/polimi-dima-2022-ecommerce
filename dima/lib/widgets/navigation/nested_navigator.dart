import 'package:flutter/material.dart';

class NestedNavigator extends StatelessWidget {
  const NestedNavigator(
      {Key? key,
      required this.navigatorKey,
      required this.initialRoute,
      required this.onGenerateRoute})
      : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final String initialRoute;
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
      observers: [], // TODO Add observers to change the scaffold's appbar
    );
  }
}
