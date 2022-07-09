import 'package:dima/firebase_options.dart';
import 'package:dima/util/authentication/authentication.dart';
import 'package:dima/util/database/database.dart';
import 'package:dima/util/user/cart_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
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
        primarySwatch: Colors.green,
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
  ApplicationState({Function? initializer}) {
    if (null != initializer) {
      // Does not work either way
      initializer();
      _testSetup();
    } else {
      init();
    }
  }
  _testSetup() async {
    // final products = await DatabaseManager.product.get();
    DatabaseManager.updateProductTester();
    DatabaseManager.updateShopTester();
    notifyListeners();
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

    // Load shared preferences
    CartManager.instance.init();
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
    FirebaseAuth.instance.userChanges().listen((user) async {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        // notify changes of user cart on child changed, or added
        final userCart = await DatabaseManager.userCart.get();
        final boughtRef = await DatabaseManager.boughtRef.get();
        final favoritesRef = await DatabaseManager.favoritesRef.get();
        final numTransactionsRef =
            await DatabaseManager.numTransactionsRef.get();
        DatabaseManager.initUserCart(userCart);
        DatabaseManager.initUserTransactions(numTransactionsRef);
        DatabaseManager.initUserHistory(boughtRef);
        DatabaseManager.initFavorites(favoritesRef);
        DatabaseManager.userCart.onChildChanged.listen((event) {
          DatabaseManager.updateUserCart(event.snapshot);
          notifyListeners();
        });
        // DatabaseManager.boughtRef.onChildAdded.listen((event) {
        //   DatabaseManager.updateHistory(event.snapshot);
        //   notifyListeners();
        // });
        // DatabaseManager.boughtRef.onChildChanged.listen((event) {
        //   DatabaseManager.updateHistory(event.snapshot);
        //   notifyListeners();
        // });
        DatabaseManager.favoritesRef.onChildChanged.listen((event) {
          DatabaseManager.updateFavorites(event.snapshot);
          notifyListeners();
        });
        DatabaseManager.userCart.onChildAdded.listen((event) {
          DatabaseManager.updateUserCart(event.snapshot);
          notifyListeners();
        });
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

    DatabaseManager.product.onChildAdded.listen((event) {
      DatabaseManager.updateProduct(event.snapshot);
      notifyListeners();
    });

    final shops = await DatabaseManager.shop.get();
    DatabaseManager.updateAllShops(shops);
    notifyListeners();
    DatabaseManager.shop.onChildChanged.listen((event) {
      DatabaseManager.updateProduct(event.snapshot);
      notifyListeners();
    });
  }
}
