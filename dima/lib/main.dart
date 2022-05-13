import 'dart:js';

import 'package:dima/firebase_options.dart';
import 'package:dima/util/authentication/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dima/util/navigation/main_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: (context, _) => const MyApp(),
  ));
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

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _firebaseAvailable = false;
  bool get firebaseAvailable => _firebaseAvailable;

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  Future<void> init() async {
    // Initialize firebase
    await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform)
        .whenComplete(() {
      _firebaseAvailable = true;
      notifyListeners();
    });

    // Listen for auth user changes
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
      } else {
        _loginState = ApplicationLoginState.loggedOut;
      }
      notifyListeners();
    });
  }
}
