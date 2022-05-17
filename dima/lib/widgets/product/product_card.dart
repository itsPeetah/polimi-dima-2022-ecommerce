import 'package:dima/main.dart';
import 'package:dima/pages/misc/hello.dart';
import 'package:dima/util/database/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/product.dart';

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
          return _buildItemBody(context);
        }
      },
    );
  }

  Widget _buildItemBody(BuildContext context) {
    Product? product = DatabaseManager.getProduct("$productId");

    if (product == null) {
      return _buildLoadingIndicator();
    }

    return Stack(
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
          padding: EdgeInsets.all(10),
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                product.name,
                style: TextStyle(fontSize: 28, color: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
