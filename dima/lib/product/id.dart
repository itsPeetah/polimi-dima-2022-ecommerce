import 'package:dima/components/dbs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductFromID extends StatelessWidget {
  const ProductFromID({Key? key, required this.productId}) : super(key: key);
  final String productId;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    var product = getProductFromId(productId);
    return SizedBox(
        width: width,
        height: 0.9 * height,
        child: ListView(
          children: [
            Text(product['id'] + "--" + product['name']),
            Image.network(product['link'])
          ],
        ));
  }
}
