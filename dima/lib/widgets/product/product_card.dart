import 'package:dima/main.dart';
import 'package:dima/pages/misc/404.dart';
import 'package:dima/pages/misc/hello.dart';
import 'package:dima/util/database/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/product.dart';

enum ProductCardSize { small, medium, large }

class ProductCard extends /*StatefulWidget*/ StatelessWidget {
  const ProductCard(
      {Key? key, required this.productId, this.size = ProductCardSize.medium})
      : super(key: key);

  final int productId;
  final ProductCardSize size;

//   @override
//   State<ProductCard> createState() => ProductCardState();
// }

// class ProductCardState extends State<ProductCard> {

//   Product? product;

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, child) {
        if (!appState.firebaseAvailable) {
          return _buildLoadingIndicator();
        } else {
          return _buildItemBody();
        }
      },
    );
  }

  Widget _buildItemBody() {
    Product? product = DatabaseManager.getProduct("$productId");

    if (product == null) {
      return _buildLoadingIndicator();
    }

    return HelloPage(title: product.name);
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
