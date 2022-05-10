import 'package:dima/components/shopping_cart/shopping_product.dart';
import 'package:dima/model/dbs.dart';
import 'package:flutter/material.dart';

class ShoppingCartRoute extends StatelessWidget {
  const ShoppingCartRoute(
      {Key? key, this.titleQuestion = 'Do you want to buy something else?'})
      : super(key: key);
  final String titleQuestion;
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (var el in getAllDb()) {
      children.add(ShoppingCartProduct(product: el, quantity: 1));
      children.add(Divider());
    }
    var body = ListView(
      scrollDirection: Axis.vertical,
      children: children,
    );
    return body;
  }
}
