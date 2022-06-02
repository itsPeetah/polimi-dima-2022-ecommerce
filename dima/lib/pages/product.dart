import 'package:dima/components/product/id.dart';
import 'package:dima/model/product.dart';
import 'package:dima/pages/misc/404.dart';
import 'package:dima/util/database/database.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({
    Key? key,
    required this.productId,
  }) : super(key: key);

  final String productId;

  @override
  Widget build(BuildContext context) {
    Product product;

    try {
      product = DatabaseManager.getProduct(productId);
    } catch (ex) {
      return const PageNotFound(
        reason: "Product not found...",
      );
    }

    return ProductFromID(
      product: product,
      productId: productId,
    );
  }
}
