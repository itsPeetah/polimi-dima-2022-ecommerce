import 'package:dima/model/product.dart';
import 'package:flutter/material.dart';

enum ProductCardSize { small, medium, large }

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key? key, this.product, this.size = ProductCardSize.medium})
      : super(key: key);
  final Product? product;
  final ProductCardSize size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildItemBody(),
    );
  }

  Widget _buildItemBody() {
    if (product == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(product!.name);
  }
}
