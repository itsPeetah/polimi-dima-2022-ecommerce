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
            height: height * 0.25,
            color: backgroundItemColor1,
            child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Padding(
                        padding: EdgeInsets.all(width * 0.01),
                        child: FittedBox(
                            fit: BoxFit.fill,
                            child: SizedBox(
                              child: widget.product.image,
                            ))),
                  ),
                  Expanded(
                      flex: 3,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ProductTitleCard(
                              text: widget.product.name,
                            ),
                            Text(
                              widget.product.price,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: productPriceSize),
                            )
                          ])),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _listOfButtons(width),
                    ),
                  ),
                ])));
  }

  List<Widget> _listOfButtons(double width) {
    return <Widget>[
      Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 3,
            child: CircleAvatar(
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
          ),
          Expanded(
            flex: 2,
            child: Container(
                padding:
                    const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(100, 255, 255, 255),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: borderColor),
                ),
                child: Text(
                  widget.product.qty.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: 'Raleway-Regular',
                      fontSize: productPriceSize),
                )),
          ),
          Expanded(
            flex: 3,
            child: CircleAvatar(
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
          ),
        ],
      )
    ];
  }
}
