import 'package:dima/components/product/id.dart';
import 'package:dima/default_scaffold.dart';
import 'package:dima/model/product.dart';
import 'package:dima/pages/misc/fork.dart';
import 'package:dima/util/database/database.dart';
import 'package:dima/widgets/product/product_card.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({
    Key? key,
    required this.productId,
  }) : super(key: key);

  final String productId;

  @override
  Widget build(BuildContext context) {
    // TODO null check
    Product p = DatabaseManager.getProduct(productId)!;
    return ProductFromID(
      product: p,
      productId: productId,
    );
  }
}
