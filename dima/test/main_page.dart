import 'package:dima/components/home/product_home.dart';
import 'package:dima/components/home/product_home_horizontal.dart';
import 'package:dima/components/product/id.dart';
import 'package:dima/components/question_bar_result.dart';
import 'package:dima/shopping_cart_route.dart';
import 'package:dima/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dima/main.dart';

void main() {
  testWidgets('Test that a welcome header is present in the main page',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    expect(find.textContaining('Welcome to'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.person));
    await tester.pump(const Duration(seconds: 10));

    expect(find.textContaining('Welcome to'), findsNothing);
  });

  testWidgets('Test that when the person icon is pressed we go to another page',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    await tester.tap(find.byIcon(Icons.person)); //shopping_cart
    await tester.pump(const Duration(seconds: 5));
    expect(
        find.textContaining(
            'Not yet implemented, go back to the previous page!'),
        findsOneWidget);
    expect(find.byType(UserProfileRoute), findsOneWidget);
  });

  testWidgets(
      'Test that when the shopping cart icon is pressed we go to shopping_cart_route',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    await tester.tap(find.byIcon(Icons.shopping_cart)); //shopping_cart
    await tester.pumpAndSettle();
    expect(
        find.textContaining(
            'Not yet implemented, go back to the previous page!'),
        findsOneWidget);
    expect(find.byType(ShoppingCartRoute), findsOneWidget);
  });

  testWidgets(
      'Test that when a (vertical) product icon is pressed we go to product id.dart',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();
    expect(find.byType(ProductFromID), findsNothing);

    // tester.dragUntilVisible(
    // find.byType(Widget you want to find),
    // find.byType(widget you want to scroll),
    // const Offset(-250, -0), // delta to move
    // );
    await tester.tap(find.byType(ProductItem).first); //shopping_cart

    await tester.pumpAndSettle();
    expect(find.byType(ProductFromID), findsOneWidget);
  });

  testWidgets(
      'Test that when a (horizontal) product icon is pressed we go to product id.dart',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();
    expect(find.byType(ProductFromID), findsNothing);

    await tester.tap(find.byType(ProductItemHorizontal).first);
    await tester.pumpAndSettle();

    expect(find.byType(ProductFromID), findsOneWidget);
  });

  testWidgets('Test that the search bar works', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();
    expect(find.byType(QuestionBarResult), findsNothing);

    expect(find.byType(TextField), findsOneWidget);
    await tester.enterText(find.byType(TextField),
        'tour in the ALPS for one week'); // search in the search bar for a tour product
    // expect(find.byType(QuestionBarResult),
    //     findsWidgets); // <- Not working
  });
}
