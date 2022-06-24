import 'package:dima/widgets/home/product_home_horizontal.dart';
import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:flutter/material.dart';

import '../model/product.dart';
import '../styles/styleoftext.dart';
import '../widgets/home/product_home.dart';
import '../widgets/shopping_cart/shopping_product.dart';

class ThanksPage extends StatelessWidget {
  const ThanksPage(
      {Key? key,
      required this.listOfProducts,
      required this.location,
      required this.price})
      : super(key: key);
  final List<Product> listOfProducts;
  final String location;
  final String price;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return _createBody(context, constraints);
    });
  }

  Widget _createBody(BuildContext context, BoxConstraints constraints) {
    List<Widget> allBought = [];
    for (Product prod in listOfProducts) {
      allBought.add(Container(
        decoration: gradientStyleWhite,
        child: ProductItem(product: prod),
      ));
    }
    return Column(
      children: <Widget>[
        const Text('Thank you for choosing our application to buy products!\n'),
        Text('\t' +
            String.fromCharCode(0x2022) +
            'The total you paid is:\$' +
            price +
            '.\n'),
        Text('\t' +
            String.fromCharCode(0x2022) +
            'Your order will be sent in \'' +
            location +
            '\', within 3 days.\n'),
        const Text('All the products that you bought are: \n'),
        SizedBox(
            height: constraints.maxHeight * 0.7,
            width: constraints.maxWidth,
            child: ListView(children: allBought)),
        TextButtonLarge(
            text: 'Understood.',
            onPressed: () {
              var count = 0;
              // pop 3 pages
              return Navigator.popUntil(context, (route) {
                return count++ == 3;
              });
            }),
      ],
    );
  }
}
