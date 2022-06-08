import 'package:dima/main.dart';
import 'package:dima/styles/styleoftext.dart';
import 'package:dima/util/navigation/navigation_nested.dart';
import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void _buyCallback() {
    SecondaryNavigator.push(context, NestedNavigatorRoutes.checkout,
        routeArgs: {'show': false});
  }

  void getListOfItemsInCart() {
    children = getItemsInCart();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: ((context, appState, _) {
        return _buildBody();
      }),
    );
  }

  _buildBody() {
    getListOfItemsInCart();
    Headline headline = (children.isEmpty)
        ? const Headline(text: 'You have no items inside your cart')
        : const Headline(text: 'These are all the items inside your cart');

    return Column(children: [
      headline,
      Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: children,
        ),
      ),
      if (children.isNotEmpty)
        TextButtonLarge(text: 'Check out', onPressed: _buyCallback),
    ]);
  }
}
