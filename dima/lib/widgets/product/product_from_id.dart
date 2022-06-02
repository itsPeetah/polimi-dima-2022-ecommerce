import 'package:dima/model/product.dart';
import 'package:dima/styles/styleoftext.dart';
import 'package:dima/util/navigation/navigation_nested.dart';
import 'package:flutter/material.dart';

/// Previously called product from id is now simply the page you get redirected when you click on a product link.
class ProductFromID extends StatefulWidget {
  const ProductFromID({Key? key, this.productId = "0", required this.product})
      : super(key: key);

  // TODO Avoid duplication!
  final String productId;
  final Product product;

  @override
  State<ProductFromID> createState() => _ProductFromIDState();
}

class _ProductFromIDState extends State<ProductFromID> {
  void _buyCallback() {
    true;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final topPadding = MediaQuery.of(context).padding.top;

    var width = size.width;
    var height = size.height - bottomPadding - topPadding;
    Widget body =
        // Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ListView(children: [
      ElevatedButton(
          onPressed: () => SecondaryNavigator.pop(context),
          child: const Text('Go Back')),
      widget.product.image,
      Text(
        widget.product.name,
        style:
            const TextStyle(color: headerTextColor, fontSize: productTitleSize),
      ),
      const Text(
          "Description -- Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"),
      //   ],
      // ),
      Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            widget.product.price,
            style: const TextStyle(fontSize: 17),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: ElevatedButton(
                onPressed: () => Product.addToCart(widget.productId),
                child: const Icon(Icons.add_shopping_cart_rounded)),
          ),
          ElevatedButton(
              onPressed: _buyCallback, child: const Text('Buy this product'))
        ],
      )
    ]);
    return body;
  }
}
