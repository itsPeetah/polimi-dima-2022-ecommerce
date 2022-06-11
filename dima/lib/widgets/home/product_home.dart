import 'package:dima/widgets/product/product_from_id.dart';
import 'package:dima/model/product.dart';
import 'package:flutter/material.dart';
import 'package:dima/styles/styleoftext.dart';

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
    return GestureDetector(

        /// TODO: change to mainnavigator
        onTap: () => Navigator.push(
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
                    padding: EdgeInsets.only(bottom: height * 0.008),
                    child: Text(product.price))
              ],
            )));
  }
}
