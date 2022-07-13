import 'package:dima/model/product.dart';
import 'package:dima/styles/styleoftext.dart';
import 'package:dima/util/navigation/navigation_nested.dart';
import 'package:dima/util/user/favorites_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../util/database/database.dart';
import '../../util/navigation/navigation_main.dart';

/// Previously called product from id is now simply the page you get redirected when you click on a product link.
class ProductFromID extends StatefulWidget {
  ProductFromID({Key? key, this.productId = "-1", required this.product})
      : super(key: key);

  String productId;
  final Product product;
  @override
  State<ProductFromID> createState() => _ProductFromIDState();
}

class _ProductFromIDState extends State<ProductFromID> {
  void _buyCallback() {
    try {
      Product.addToCart(widget.productId);
    } catch (exception) {
      true;
    }

    // final r = MainNavigatorRouter.generateRoute(const RouteSettings(
    //     name: MainNavigationRoutes.checkout, arguments: {'show': false}));
    MainNavigator.push(MainNavigationRoutes.checkout,
        arguments: {'show': true});
    // MainNavigator.mainNavigatorKey.currentState!.push(r!);
    // SecondaryNavigator.push(context, NestedNavigatorRoutes.checkout,
    //     routeArgs: {'show': true});
  }

  final Color pinkHeart = const Color.fromARGB(255, 255, 57, 126);
  late Color heartColor;

  @override
  Widget build(BuildContext context) {
    if (widget.productId == '-1') {
      widget.productId = widget.product.id;
    }
    heartColor = pinkHeart;
    // var width = context.size.width;

    return Consumer<ApplicationState>(builder: ((context, appState, _) {
      return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return _createBody(context, constraints);
      });
    }));
  }

  Widget _createBody(BuildContext context, BoxConstraints constraints) {
    var width = constraints.maxWidth;
    var height = constraints.maxHeight;
    var imageHeight = height * 0.8;
    if (DatabaseManager.favorites[widget.productId] == null ||
        DatabaseManager.favorites[widget.productId].qty == 0) {
      heartColor = Colors.white;
    }
    Widget body = ListView(children: [
      SizedBox(
          child: FittedBox(child: widget.product.image),
          width: width,
          height: imageHeight),
      Text(
        widget.product.name,
        style:
            // TODO: ADAPT SIZE OF FONT
            TextStyle(
                color: headerTextColor,
                fontSize: constraints.maxWidth <= tabletWidth
                    ? productTitleSize
                    : productTitleSizeTablet),
      ),
      Text(
        "Description -- Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
        style:
            TextStyle(fontSize: constraints.maxWidth <= tabletWidth ? 12 : 18),
      ),
      //   ],
      // ),
      Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            widget.product.price,
            // TODO: ADAPT SIZE OF FONT
            style: TextStyle(
                fontSize: constraints.maxWidth <= tabletWidth ? 17 : 17 + 13),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: ElevatedButton(
                onPressed: () {
                  removeOrAddFav();
                },
                child: Icon(Icons.favorite, color: heartColor)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child:
                // TODO: ADAPT SIZE OF BUTTON FOR TABLET
                ElevatedButton(
                    onPressed: () {
                      Product.addToCart(widget.productId);
                    },
                    child: const Icon(Icons.add_shopping_cart_rounded)),
          ),
          ElevatedButton(
              onPressed: _buyCallback, child: const Text('Buy this product'))
        ],
      )
    ]);
    return body;
  }

  void removeOrAddFav() {
    if (DatabaseManager.favorites[widget.productId] == null ||
        DatabaseManager.favorites[widget.productId].qty == 0) {
      Product.addToFavorites(widget.productId);

      setState(() {
        heartColor = pinkHeart;
      });
    } else {
      Product.removeFromFavorites(widget.productId);
      setState(() {
        heartColor = Colors.white;
      });
    }
  }
}
