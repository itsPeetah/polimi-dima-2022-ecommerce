import 'package:carousel_slider/carousel_slider.dart';
import 'package:dima/firebase_options.dart';
import 'package:dima/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_database_mocks/firebase_database_mocks.dart';
import 'package:firebase_database/firebase_database.dart';
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
  });
  // TESTS
  testWidgets('Test that from home page we can go anywhere',
      (WidgetTester tester) async {
    // final userNameFromFakeDatabase = await UserMock.getUserName(userId);
    // expect(userNameFromFakeDatabase, equals(userName));

    firebaseDatabase = MockFirebaseDatabase.instance;
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => ApplicationState(initializer: firebaseDatabase),
      builder: (context, _) => const MyApp(),
    ));

    expect(find.byType(CarouselSlider, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.map_outlined), findsOneWidget);
    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.byType(Image, skipOffstage: false), findsOneWidget);
  });
}
