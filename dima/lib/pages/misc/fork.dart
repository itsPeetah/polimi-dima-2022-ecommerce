import 'package:flutter/material.dart';
import 'package:dima/main.dart';
import 'package:dima/util/navigation/main_routes.dart';
import 'package:dima/util/navigation/nested_routes.dart';

class ForkPage extends StatelessWidget {
  const ForkPage(
      {Key? key,
      required this.title,
      required this.route1,
      required this.route2})
      : super(key: key);

  final String title;
  final String route1;
  final String route2;

  void _navigate(BuildContext context, String route) {
    final RouteSettings rs = RouteSettings(name: route);
    final Route? r = NestedNavigatorRouter.generateRoute(rs);

    Navigator.push(context, r!);
  }

  void _goBack(BuildContext context) {
    Navigator.pop(context);
  }

  void _pushMain() {
    const rs = RouteSettings(name: "/foobar");
    final r = MainNavigatorRouter.generateRoute(rs);
    MainNavigator.mainNavigatorKey.currentState!.push(r!);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 28)),
          TextButton(
            onPressed: () => _navigate(context, route1),
            child: Text("Go to $route1", style: const TextStyle(fontSize: 28)),
          ),
          TextButton(
            onPressed: () => _navigate(context, route2),
            child: Text("Go to $route2", style: const TextStyle(fontSize: 28)),
          ),
          Container(
            child: _backButton(context),
          ),
          TextButton(
            onPressed: _pushMain,
            child: const Text("Push main (will 404)",
                style: TextStyle(fontSize: 28)),
          ),
        ],
      ),
    );
  }

  Widget? _backButton(BuildContext context) {
    bool canGoBack = Navigator.of(context).canPop();
    return canGoBack
        ? TextButton(
            onPressed: () => _goBack(context),
            child: const Text("Go back", style: TextStyle(fontSize: 28)),
          )
        : null;
  }
}
