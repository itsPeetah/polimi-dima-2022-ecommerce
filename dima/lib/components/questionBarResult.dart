import 'package:dima/product/id.dart';
import 'package:flutter/material.dart';
import 'package:dima/styles/styleoftext.dart';

class QuestionBarResult extends StatelessWidget {
  const QuestionBarResult({
    Key? key,
    required this.product,
  }) : super(key: key);
  final dynamic product;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width * .9;
    var height = size.height;
    return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductFromID(productId: product['id'].toString()))),
        child: Container(
            color: backgroundItemColor1,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width / 2,
                  child: Padding(
                      padding: EdgeInsets.all(width * 0.01),
                      child: Image.network(
                        product['link'],
                        width: width * 0.4,
                        height: height * 0.25,
                      )),
                ),
                SizedBox(
                    width: width / 2,
                    child: Column(children: [
                      Text(product['name'].toString(),
                          style: const TextStyle(fontSize: productTitleSize),
                          textAlign: TextAlign.center),
                      Text(
                        product['price'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Raleway-Regular',
                            fontSize: productPriceSize),
                      )
                    ])),
              ],
            )));
  }
}
