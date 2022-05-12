import 'package:dima/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dima/util/navigation/main_routes.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Nested Navigation Tests',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      /* Entry Point -> MainNavigation (tabbed view) */
      initialRoute: MainNavigationRoutes.root,
      /* Here to create pages based on route */
      onGenerateRoute: MainNavigatorRouter.generateRoute,
      navigatorKey: MainNavigator.mainNavigatorKey,
    );
  }
}
