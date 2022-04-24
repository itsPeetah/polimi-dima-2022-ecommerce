import 'package:dima/product/id.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dima/styles/styleoftext.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);
  final dynamic product;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductFromID(product['id'].toString()))),
        child: Container(
            color: backgroundItemColor1,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(width * 0.02),
                    child: Image.network(
                      product['link'],
                      width: width * 0.4,
                      height: height * 0.25,
                    )),
                Text(
                  product['name'].toString(),
                ),
                Text(product['price'])
              ],
            )));
  }
}
