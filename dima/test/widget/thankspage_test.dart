import 'package:dima/model/product.dart';
import 'package:dima/pages/thankspage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check that the Thank You page is correctly instantiated',
      (WidgetTester tester) async {
    String productName = 'Name of Product';
    String orderPlace = 'Here, There, 19192, MA';
    String totalPrice = '259';
    Product product = Product(
      id: '0',
      name: productName,
      price: totalPrice,
      image: Image.asset(
        'images/twoMenShakingHands.jpg',
        scale: 0.1,
      ),
      imageLink: 'https://picsum.photos/250?image=9',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox(
          height: 800,
          width: 400,
          // We need a gridview because otherwise the page overflows.
          child: GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 0.20,
            children: [
              ThanksPage(
                listOfProducts: [product],
                location: orderPlace,
                price: totalPrice,
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
        find.textContaining(orderPlace, skipOffstage: false), findsOneWidget);
    expect(
        find.textContaining(totalPrice, skipOffstage: false), findsNWidgets(2));
    expect(
        find.textContaining(productName, skipOffstage: false), findsOneWidget);
    expect(find.byType(ListView, skipOffstage: false), findsOneWidget);
  });
}
