import 'package:dima/main.dart';
import 'package:dima/pages/authentication/signin.dart';
import 'package:dima/pages/search_products.dart';
import 'package:dima/util/database/database.dart';
import 'package:dima/widgets/product/product_card.dart';
import 'package:dima/widgets/shopping_cart/shopping_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Check Shopping cart product of type product',
      (WidgetTester tester) async {
    DatabaseManager.updateProductTester();
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => ApplicationState(initializer: () {
        return;
      }),
      builder: (context, _) => MaterialApp(
        home: Scaffold(
            body: Center(
          child: ShoppingCartProduct(
              product: DatabaseManager.allProducts['0'], quantity: 1),
        )),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.add, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(Icons.remove, skipOffstage: false), findsOneWidget);
  });

  testWidgets('Check Shopping cart product of type favorites',
      (WidgetTester tester) async {
    DatabaseManager.updateProductTester();
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => ApplicationState(initializer: () {
        return;
      }),
      builder: (context, _) => MaterialApp(
        home: Scaffold(
            body: Center(
          child: ShoppingCartProduct(
            product: DatabaseManager.allProducts['0'],
            quantity: 1,
            typeOfPage: 'favorites',
          ),
        )),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(Icons.add_shopping_cart, skipOffstage: false),
        findsOneWidget);
  });

  testWidgets('Check Shopping cart product of type history',
      (WidgetTester tester) async {
    DatabaseManager.updateProductTester();
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => ApplicationState(initializer: () {
        return;
      }),
      builder: (context, _) => MaterialApp(
        home: Scaffold(
            body: Center(
          child: ShoppingCartProduct(
            product: DatabaseManager.allProducts['0'],
            quantity: 1,
            typeOfPage: 'history',
          ),
        )),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.textContaining("Purchased the: 4/1/1998", skipOffstage: false),
        findsOneWidget);
  });
}
