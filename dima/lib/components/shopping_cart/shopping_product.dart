import 'package:dima/components/product/id.dart';
import 'package:dima/model/product.dart';
import 'package:dima/styles/styleoftext.dart';
import 'package:flutter/material.dart';

class ShoppingCartProduct extends StatelessWidget {
  const ShoppingCartProduct(
      {Key? key, required this.product, required this.quantity})
      : super(key: key);
  final Product product;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width * .9;
    var height = size.height;
    var body = GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductFromID(product: product))),
        child: Container(
            height: height * 0.23,
            color: backgroundItemColor1,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  // width: width / 5,
                  child: Padding(
                      padding: EdgeInsets.all(width * 0.01),
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: SizedBox(
                            child: product.image,
                            width: width * 0.2,
                            height: height * 0.2,
                          ))),
                ),
                Flexible(
                    flex: 4,
                    // width: 2 * width / 4,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(product.name,
                              style:
                                  const TextStyle(fontSize: productTitleSize),
                              textAlign: TextAlign.center),
                          Text(
                            product.price,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'Raleway-Regular',
                                fontSize: productPriceSize),
                          )
                        ])),
                Flexible(
                    flex: 3,
                    // width: width / 4,
                    child: Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    // size: buttonSize,
                                  ))),
                          Flexible(
                              flex: 3,
                              child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(50, 255, 255, 255),
                                    border: Border.all(color: borderColor),
                                  ),
                                  child: Text(
                                    quantity.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontFamily: 'Raleway-Regular',
                                        fontSize: productPriceSize),
                                  ))),
                          Flexible(
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child:
                                      const Icon(Icons.add, size: buttonSize))),
                        ])),
              ],
            )));
    return body;
  }
}
