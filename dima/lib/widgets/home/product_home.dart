import 'dart:math';

import 'package:dima/widgets/product/product_from_id.dart';
import 'package:dima/model/product.dart';
import 'package:flutter/material.dart';
import 'package:dima/styles/styleoftext.dart';

// Used in Thankyou page and payment recap page
class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    var bottomPadding = min(30, height * 0.008) as double;
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Colors.black.withOpacity((0))),
          shadowColor: MaterialStateProperty.all(Colors.black.withOpacity((0))),
        ),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductFromID(productId: product.id, product: product))),
        child: Container(
            color: backgroundItemColor1,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(height * 0.005),
                    child: SizedBox(
                      child: product.image,
                      width: width * 0.8,
                      height: height * 0.6,
                    )),
                ProductTitleCard(
                  text: product.name,
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: bottomPadding),
                    child: Text(product.price,
                        style: const TextStyle(color: Colors.black)))
              ],
            )));
  }
}
