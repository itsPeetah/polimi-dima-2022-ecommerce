import 'package:dima/widgets/product/product_from_id.dart';
import 'package:dima/model/product.dart';
import 'package:flutter/material.dart';
import 'package:dima/styles/styleoftext.dart';

class ProductItemHorizontal extends StatelessWidget {
  const ProductItemHorizontal({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width * .9;
    var height = size.height;
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Colors.black.withOpacity((0))),
          shadowColor: MaterialStateProperty.all(Colors.black.withOpacity((0))),
        ),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductFromID(product: product))),
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
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: SizedBox(
                            child: product.image,
                            width: width * 0.4,
                            height: height * 0.25,
                          ))),
                ),
                SizedBox(
                    width: width / 2,
                    child: Column(children: [
                      ProductTitleCard(
                        text: product.name,
                      ),
                      Text(
                        product.price,
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
