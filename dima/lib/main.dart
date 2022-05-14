import 'package:dima/firebase_options.dart';
import 'package:dima/util/authentication/authentication.dart';
import 'package:dima/util/database/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dima/util/navigation/navigation_main.dart';
import 'package:provider/provider.dart';

void main() async {
  // TODO: Maybe make this a multiprovider
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
    await _initializeFirebase();

    // Listen for auth user changes
    _subscribeToAuthChanges();

    // Listen for changes to the catalogue
    _subscribeToProductCatalogue();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform)
        .whenComplete(() {
      _firebaseAvailable = true;
      notifyListeners();
    });
  }

  void _subscribeToAuthChanges() {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
      } else {
        _loginState = ApplicationLoginState.loggedOut;
      }
      notifyListeners();
    });
  }

  void _subscribeToProductCatalogue() async {
    final products = await DatabaseManager.product.get();
    DatabaseManager.updateProductStore(products);
    notifyListeners();

    DatabaseManager.product.onChildChanged.listen((event) {
      DatabaseManager.updateProduct(event.snapshot);
      notifyListeners();
    });
  }
}
