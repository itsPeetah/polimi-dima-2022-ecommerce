import 'package:dima/model/product.dart';
import 'package:dima/styles/styleoftext.dart';
import 'package:dima/util/navigation/navigation_nested.dart';
import 'package:dima/widgets/shopping_cart/shopping_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'list_of_products.dart';

class ShoppingCartRoute extends StatefulWidget {
  const ShoppingCartRoute(
      {Key? key, this.titleQuestion = 'Do you want to buy something else?'})
      : super(key: key);
  final String titleQuestion;

  @override
  State<ShoppingCartRoute> createState() => ShoppingCartRouteState();
}

class ShoppingCartRouteState extends State<ShoppingCartRoute> {
  List<Widget> children = [];
  bool called = false;
  void _buyCallback() {
    SecondaryNavigator.push(context, NestedNavigatorRoutes.checkout,
        routeArgs: {'show': false});
  }

  @override
  void initState() {
    super.initState();
    getListOfItemsInCart();
  }

  _rebuild() {
    setState(() {
      getListOfItemsInCart();
    });
    // build(context);
  }

  void getListOfItemsInCart() async {
    List<Widget> listOfWidgets = await getItemsInCart();
    setState(() {
      called = true;
      children = listOfWidgets;
    });
  }

  @override
  Widget build(BuildContext context) {
    Headline headline = (children.isEmpty)
        ? const Headline(text: 'You have no items inside your cart')
        : const Headline(text: 'These are all the items inside your cart');

    var body = Column(children: [
      headline,
      Expanded(
          child: ListView(
        scrollDirection: Axis.vertical,
        children: children,
      )),
      if (children.isNotEmpty)
        ElevatedButton(onPressed: _buyCallback, child: const Text('Check out'))
    ]);
    return body;
  }
}
