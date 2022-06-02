import 'package:dima/main.dart';
import 'package:dima/util/database/database.dart';
import 'package:dima/util/navigation/navigation_nested.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/product.dart';

enum ProductCardSize { small, medium, large }

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key? key, required this.productId, this.size = ProductCardSize.medium})
      : super(key: key);

  final String productId;
  final ProductCardSize size;

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, child) {
        if (!appState.firebaseAvailable) {
          return _buildLoadingIndicator();
        } else {
          return _buildItemBody(context);
        }
      },
    );
  }

  void _goToProductPage(BuildContext context) {
    SecondaryNavigator.push(context, "/product", routeArgs: {"id": productId});
  }

  Widget _buildItemBody(BuildContext context) {
    Product product;
    try {
      product = DatabaseManager.getProduct(productId);
    } catch (ex) {
      return _buildLoadingIndicator();
    }

    return GestureDetector(
      onTap: () => _goToProductPage(context),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: product.image.image,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.low,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: <Color>[
                  Color(0x99000000),
                  Color(0x00000000),
                ],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 28, color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
