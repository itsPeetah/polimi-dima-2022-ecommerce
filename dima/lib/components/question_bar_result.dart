import 'package:dima/components/model/product.dart';
import 'package:dima/product/id.dart';
import 'package:flutter/material.dart';
import 'package:dima/styles/styleoftext.dart';

class QuestionBarResult extends StatelessWidget {
  const QuestionBarResult({
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
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductFromID(product: product))),
        child: Container(
            color: questionBarColor,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.28,
                  width: width / 2,
                  child: Padding(
                      padding: EdgeInsets.all(width * 0.03),
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: SizedBox(
                            child: product.image,
                            height: height * 0.22,
                          ))),
                ),
                SizedBox(
                    width: width * 0.35,
                    child: Column(children: [
                      Text(product.name,
                          style: const TextStyle(
                              fontSize: productTitleSize,
                              color: questionBarTextColor),
                          textAlign: TextAlign.center),
                      Text(
                        product.price,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: questionBarTextColor,
                            fontFamily: 'Raleway-Regular',
                            fontSize: productPriceSize),
                      )
                    ])),
              ],
            )));
  }
}
