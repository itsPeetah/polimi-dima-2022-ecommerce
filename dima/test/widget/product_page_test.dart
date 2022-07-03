import 'package:dima/model/product.dart';
import 'package:dima/pages/authentication/signin.dart';
import 'package:dima/widgets/product/product_from_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('Check that the product page is correctly instantiated',
      (WidgetTester tester) async {
    Product product = Product(
      id: '0',
      name: 'Laptop Chewui 14!',
      price: '259',
      image: Image.asset(
        'images/twoMenShakingHands.jpg',
        scale: 0.1,
      ),
      imageLink: 'https://picsum.photos/250?image=9',
    );

    await mockNetworkImagesFor(() async => await tester.pumpWidget(MaterialApp(
        home: SizedBox.expand(
            child: Container(
                color: Colors.black,
                child: ProductFromID(
                  product: product,
                  productId: product.id,
                ))))));
    expect(find.byIcon(Icons.favorite, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(Icons.add_shopping_cart_rounded, skipOffstage: false),
        findsOneWidget);
    expect(find.byType(Image, skipOffstage: false), findsOneWidget);
    expect(find.textContaining('Buy', skipOffstage: false), findsOneWidget);
  });
}
