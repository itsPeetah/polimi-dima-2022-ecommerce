import 'package:dima/components/dbs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/questionbar.dart';

class ProductFromID extends StatelessWidget {
  ProductFromID(this.productId, {Key? key}) : super(key: key);
  String productId;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    var product = getProductFromId(productId);
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 60,
            flexibleSpace: const SafeArea(
                child: QuestionBar(title: "Search on AppName.com"))),
        body: SizedBox(
            width: width,
            height: 0.9 * height,
            child: ListView(
              children: [
                Text(product['id'] + "--" + product['name']),
                Image.network(product['link'])
              ],
            )));
  }
}
