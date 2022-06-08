import 'package:dima/widgets/product/product_from_id.dart';
import 'package:dima/model/product.dart';
import 'package:dima/styles/styleoftext.dart';
import 'package:flutter/material.dart';

class ShoppingCartProduct extends StatefulWidget {
  const ShoppingCartProduct(
      {Key? key,
      required this.product,
      required this.quantity,
      this.parentRebuild})
      : super(key: key);
  final Product product;
  final int quantity;
  final dynamic parentRebuild;

  @override
  State<ShoppingCartProduct> createState() => ShoppingCartProductState();
}

class ShoppingCartProductState extends State<ShoppingCartProduct> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    if (widget.quantity <= 0) {
      return SizedBox.shrink();
    }
    var size = MediaQuery.of(context).size;
    var width = size.width * .9;
    var height = size.height;
    return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductFromID(product: widget.product))),
        child: Container(
            height: height * 0.15,
            color: backgroundItemColor1,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width / 6,
                  child: Padding(
                      padding: EdgeInsets.all(width * 0.01),
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: SizedBox(
                            child: widget.product.image,
                            // width: width * 0.2,
                            // height: height * 0.2,
                          ))),
                ),
                SizedBox(
                    width: 2 * width / 4,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.product.name,
                              style:
                                  const TextStyle(fontSize: productTitleSize),
                              textAlign: TextAlign.center),
                          Text(
                            widget.product.price,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'Raleway-Regular',
                                fontSize: productPriceSize),
                          )
                        ])),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        // radius: 10,
                        // backgroundColor: Color,
                        child: IconButton(
                          onPressed: () {
                            Product.removeFromCart(widget.product.id);
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.remove,
                          ),
                        ),
                      ),
                      SizedBox(
                          width: width / 10,
                          child: Container(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 0, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(50, 255, 255, 255),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: borderColor),
                              ),
                              child: Text(
                                widget.product.qty.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: 'Raleway-Regular',
                                    fontSize: productPriceSize),
                              ))),
                      CircleAvatar(
                        // radius: 10,
                        // backgroundColor: Color,
                        child: IconButton(
                          onPressed: () {
                            Product.addToCart(widget.product.id);
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.add,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
