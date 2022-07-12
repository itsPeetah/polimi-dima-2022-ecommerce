import 'package:carousel_slider/carousel_slider.dart';
import 'package:dima/firebase_options.dart';
import 'package:dima/main.dart';
import 'package:dima/model/product.dart';
import 'package:dima/pages/thankspage.dart';
import 'package:dima/styles/styleoftext.dart';
import 'package:dima/util/database/database.dart';
import 'package:dima/widgets/shopping_cart/shopping_cart_route.dart';
import 'package:dima/widgets/shopping_cart/shopping_product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_database_mocks/firebase_database_mocks.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class UserMock {
  UserMock(this.firebaseDatabase);
  FirebaseDatabase firebaseDatabase;

  Future<String?> getUserName(String userId) async {
    final userNameReference =
        firebaseDatabase.ref().child('users').child(userId).child('name');
    final databaseEvent = await userNameReference.once();
    return databaseEvent.snapshot.value as String?;
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    final userNode = firebaseDatabase.ref().child('users/$userId');
    final databaseEvent = await userNode.once();
    return databaseEvent.snapshot.value as Map<String, dynamic>?;
  }
}

class ProductMock {
  ProductMock(this.firebaseDatabase);
  FirebaseDatabase firebaseDatabase;

  // Future<String?> getProductName(String userId) async {
  //   final userNameReference =
  //       firebaseDatabase.ref().child('users').child(userId).child('name');
  //   final databaseEvent = await userNameReference.once();
  //   return databaseEvent.snapshot.value as String?;
  // }

  Future<Map<String, dynamic>?> getProduct(String prodId) async {
    final userNode = firebaseDatabase.ref().child('product/$prodId');
    final databaseEvent = await userNode.once();
    return databaseEvent.snapshot.value as Map<String, dynamic>?;
  }
}

void main() {
  // SETUP

  FirebaseDatabase firebaseDatabase;
  late UserMock userMock;
  late ProductMock productMock;
  // Put fake data
  const userId = 'userId';
  const userName = 'Elon musk';
  const prodId = '0';
  const fakeData = {
    'users': {
      userId: {
        'name': userName,
        'email': 'musk.email@tesla.com',
      },
      'otherUserId': {
        'name': 'userName',
        'email': 'othermusk.email@tesla.com',
      }
    },
    'products': {
      prodId: {
        'name': 'Laptop Chewui 14!',
        'price': '259',
        'link': 'images/twoMenShakingHands.jpg',
      }
    }
  };

  MockFirebaseDatabase.instance.ref().set(fakeData);
  setUp(() {
    firebaseDatabase = MockFirebaseDatabase.instance;
    userMock = UserMock(firebaseDatabase);
    productMock = ProductMock(firebaseDatabase);
    DatabaseManager.updateProductTester();
    DatabaseManager.updateShopTester();
  });
  // TESTS
  testWidgets('Test that from home page we can go anywhere',
      (WidgetTester tester) async {
    MyApp _myApp = const MyApp();
    await tester.runAsync(() async {
      await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => ApplicationState(initializer: () {
          DatabaseManager.updateCartTester();
          return;
        }),
        builder: (context, _) => _myApp,
      ));
    });
    expect(find.byType(CarouselSlider, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.map_outlined), findsOneWidget);
    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);

    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();
    String whenCartIsEmpty = 'You have no items inside your cart';
    String whenHasItemsInCart = 'These are all the items inside your cart';
    String buttonText = 'Check out';
    await tester.pumpAndSettle();
    expect(find.textContaining(whenHasItemsInCart), findsNothing);
    expect(find.textContaining(buttonText), findsNothing);
    expect(find.textContaining(whenCartIsEmpty), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.map_outlined), findsOneWidget);
    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);

    String notLoggedIn = 'You are not signed in.';
    String signIn = 'Sign In';
    String signUp = 'Sign Up';
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();
    expect(find.textContaining(notLoggedIn), findsOneWidget);
    expect(find.textContaining(signIn), findsOneWidget);
    expect(find.textContaining(signUp), findsOneWidget);

    String mapsText = 'All the shops close to you';
    await tester.tap(find.byIcon(Icons.map_outlined));
    await tester.pumpAndSettle();
    expect(find.textContaining(mapsText), findsOneWidget);
    expect(find.byType(GoogleMap), findsOneWidget);
  });

  testWidgets('Mocked test for buying ', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(600, 1400);
    // Suppose we have one item in the cart and we want to check out
    DatabaseManager.updateCartTester();
    MyApp _myApp = const MyApp();
    await tester.runAsync(() async {
      await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => ApplicationState(initializer: () {
          // DatabaseManager.updateCartTester();
          return;
        }),
        builder: (context, _) => _myApp,
      ));
    });
    String whenCartIsEmpty = 'You have no items inside your cart';
    String whenHasItemsInCart = 'These are all the items inside your cart';
    String buttonText = 'Check out';
    // Cart page
    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();
    expect(find.textContaining(whenHasItemsInCart), findsOneWidget);
    expect(find.textContaining(buttonText), findsOneWidget);
    expect(find.textContaining(whenCartIsEmpty), findsNothing);
    //
    Finder _nameFinder =
        find.textContaining('Enter your name', skipOffstage: false);
    Finder _locFinder =
        find.textContaining('Enter your desired location', skipOffstage: false);

    // Delivery Details Page
    await tester.tap(find.textContaining(buttonText));
    await tester.pumpAndSettle();
    expect(_nameFinder, findsOneWidget);
    expect(_locFinder, findsOneWidget);
    expect(find.textContaining('Enter your phone number', skipOffstage: false),
        findsOneWidget);
    expect(
        find.byType(TextButton, skipOffstage: false), findsAtLeastNWidgets(2));
    expect(find.byType(TextFormField, skipOffstage: false), findsNWidgets(3));
    expect(find.byType(Form, skipOffstage: false), findsOneWidget);
    var _notPressThis = [];
    for (final element
        in find.byType(TextButton, skipOffstage: false).evaluate()) {
      _notPressThis.add(element);
    }

    var _paymentControllerWidgets = [];
    for (final element
        in find.byType(TextFormField, skipOffstage: false).evaluate()) {
      TextFormField widget = element.widget as TextFormField;
      widget.controller!.text = 'Something';
      _paymentControllerWidgets.add(element);
      // await tester.tapAt(tester.getCenter(find.byWidget(element.widget)));
    }

    // await tester.enterText(
    //     find.textContaining('Enter your name', skipOffstage: false),
    //     'Tester-Name');
    // await tester.tapAt(find.bySemanticsLabel('Enter your desired location'));
    // await tester.enterText(find.bySemanticsLabel('Enter your desired location'),
    // 'Tester-Location');
    await tester.pumpAndSettle();

    // Payment Details Page
    await tester.tap(find.textContaining('Continue'));
    await tester.pumpAndSettle();
    Finder _cvvFinder = find.textContaining('CVV', skipOffstage: false);
    Finder _ccnFinder = find.textContaining('Credit Card', skipOffstage: false);
    expect(_ccnFinder, findsOneWidget);
    expect(_cvvFinder, findsOneWidget);
    expect(find.textContaining('name', skipOffstage: false),
        findsAtLeastNWidgets(2));
    expect(
        find.textContaining('Continue', skipOffstage: false), findsNWidgets(2));
    expect(find.textContaining('Go back', skipOffstage: false), findsOneWidget);
    expect(find.byType(TextButton, skipOffstage: false), findsNWidgets(5));
    expect(find.byType(TextFormField, skipOffstage: false), findsNWidgets(6));
    expect(find.byType(Form, skipOffstage: false), findsNWidgets(2));

    for (final element
        in find.byType(TextFormField, skipOffstage: false).evaluate()) {
      if (_paymentControllerWidgets.contains(element)) {
        continue;
      }
      TextFormField widget = element.widget as TextFormField;
      widget.controller!.text = '1234123412341234';
      if (widget.validator != null &&
          widget.validator!('1234123412341234') != null) {
        widget.controller!.text = '123';
      }
    }
    await tester.tap(find.byType(Checkbox));
    for (final element
        in find.textContaining('Continue', skipOffstage: false).evaluate()) {
      await tester.runAsync(() async {
        await tester
            .ensureVisible(find.byWidget(element.widget, skipOffstage: false));
        await tester.tap(find.byWidget(element.widget, skipOffstage: false));
      });
    }
    await tester.pumpAndSettle();
    // Thanks page

    // expect(
    //     find.textContaining('Thank you', skipOffstage: false), findsOneWidget);
    // expect(find.textContaining('The total you paid is', skipOffstage: false),
    //     findsOneWidget);
    // expect(find.textContaining('Your order will be sent', skipOffstage: false),
    //     findsOneWidget);
    // expect(find.textContaining('products the', skipOffstage: false),
    //     findsOneWidget);
    // expect(find.byType(ListView, skipOffstage: false), findsOneWidget);
    // expect(find.byType(TextButton, skipOffstage: false), findsNWidgets(6));

    // return;
  });

  testWidgets('Mocked test for removing from cart ',
      (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(600, 1400);
    // Suppose we have one item in the cart and we want to check out
    DatabaseManager.updateCartTester();
    MyApp _myApp = const MyApp();
    await tester.runAsync(() async {
      await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => ApplicationState(initializer: () {
          return;
        }),
        builder: (context, _) => _myApp,
      ));
    });
    String whenCartIsEmpty = 'You have no items inside your cart';
    String whenHasItemsInCart = 'These are all the items inside your cart';
    String buttonText = 'Check out';
    // Cart page
    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();
    expect(find.textContaining(whenHasItemsInCart), findsOneWidget);
    expect(find.textContaining(buttonText), findsOneWidget);
    expect(find.textContaining(whenCartIsEmpty), findsNothing);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();
    expect(find.textContaining(whenHasItemsInCart), findsNothing);
    expect(find.textContaining(buttonText), findsNothing);
    expect(find.textContaining(whenCartIsEmpty), findsOneWidget);
  });

  testWidgets('Mocked test for removing from cart ',
      (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(600, 1400);
    // Suppose we have one item in the cart and we want to check out
    DatabaseManager.updateCartTester();
    MyApp _myApp = const MyApp();
    await tester.runAsync(() async {
      await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => ApplicationState(initializer: () {
          return;
        }),
        builder: (context, _) => _myApp,
      ));
    });
    // Cart page
    await tester.tap(find.byType(Image));
    await tester.pumpAndSettle();
    expect(find.textContaining('Lorem Ipsum'), findsOneWidget);
  });
}
