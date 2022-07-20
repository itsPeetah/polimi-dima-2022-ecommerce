import 'package:dima/main.dart';
import 'package:dima/pages/authentication/signin.dart';
import 'package:dima/pages/search_products.dart';
import 'package:dima/pages/shopPage.dart';
import 'package:dima/util/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Check that the shop page is rendered correctly',
      (WidgetTester tester) async {
    DatabaseManager.updateShopTester();

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ApplicationState(initializer: () {
          return;
        }),
        builder: (context, _) => const MaterialApp(
          home: Scaffold(body: ShopPage(shopId: '0')),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining("Luigi Vitonno", skipOffstage: false),
        findsOneWidget);
  });

  testWidgets('Check that the shop page displays the product',
      (WidgetTester tester) async {
    DatabaseManager.updateProductTester();
    DatabaseManager.updateShopTester();

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ApplicationState(initializer: () {
          return;
        }),
        builder: (context, _) => const MaterialApp(
          home: Scaffold(body: ShopPage(shopId: '0')),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(Image, skipOffstage: false), findsOneWidget);
    expect(find.textContaining("Chuwi", skipOffstage: false), findsOneWidget);
  });
}
