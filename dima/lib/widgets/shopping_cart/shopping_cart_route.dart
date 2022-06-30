import 'package:dima/main.dart';
import 'package:dima/styles/styleoftext.dart';
import 'package:dima/util/navigation/navigation_main.dart';
import 'package:dima/util/navigation/navigation_nested.dart';
import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../util/database/list_of_products.dart';

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
    MainNavigator.push(MainNavigationRoutes.checkout,
        arguments: {'show': false});
  }

  void getListOfItemsInCart(double _maxWidth, double _maxHeight) {
    children = getItemsInCart();
    if (_maxWidth >= tabletWidth) {
      children = getItemsOnly(_maxHeight);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: ((context, appState, _) {
        return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return _buildBody(constraints);
        });
      }),
    );
  }

  _buildBody(BoxConstraints constraints) {
    var _maxWidth = constraints.maxWidth;
    var _maxHeight = constraints.maxHeight;
    getListOfItemsInCart(_maxWidth, _maxHeight);
    Headline headline = (children.isEmpty)
        ? const Headline(text: 'You have no items inside your cart')
        : const Headline(text: 'These are all the items inside your cart');
    Widget _view = Expanded(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: children,
      ),
    );
    // var size_ = MediaQuery.of(context).size;
    if (_maxWidth >= tabletWidth) {
      print('Tablet mode');
      var _gridComponent = GridView.count(
          childAspectRatio: 16 / 8,
          padding: const EdgeInsets.all(2),
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          scrollDirection: Axis.vertical,
          children: children);
      // int limit = children.length ~/ 2;
      // int limit_next = limit + 1;
      // var _listViewComp = ListView(
      //   scrollDirection: Axis.vertical,
      //   children: children,
      // );

      _view = Expanded(child: _gridComponent);
    }
    return Column(children: [
      headline,
      children.isEmpty ? const SizedBox(width: 10, height: 10) : _view,
      if (children.isNotEmpty)
        TextButtonLarge(text: 'Check out', onPressed: _buyCallback),
    ]);
  }
}
