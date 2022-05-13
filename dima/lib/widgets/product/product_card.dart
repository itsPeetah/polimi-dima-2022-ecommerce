import 'package:dima/main.dart';
import 'package:dima/model/product.dart';
import 'package:dima/pages/misc/hello.dart';
import 'package:dima/util/database/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ProductCardSize { small, medium, large }

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key? key, required this.productId, this.size = ProductCardSize.medium})
      : super(key: key);
  final int productId;
  final ProductCardSize size;

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
    return HelloPage(title: "Hello product $productId");
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
