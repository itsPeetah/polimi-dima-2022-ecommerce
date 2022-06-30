import 'dart:math';

import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:dima/widgets/product/product_from_id.dart';
import 'package:dima/model/product.dart';
import 'package:dima/styles/styleoftext.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShoppingCartProduct extends StatefulWidget {
  const ShoppingCartProduct(
      {Key? key,
      required this.product,
      required this.quantity,
      this.typeOfPage = 'product'})
      : super(key: key);
  final Product product;
  final int quantity;
  final dynamic typeOfPage;
  static const String productSimple = "product";
  static const String favorites = "favorites";
  static const String history = "history";
  @override
  State<ShoppingCartProduct> createState() => ShoppingCartProductState();
}

class ShoppingCartProductState extends State<ShoppingCartProduct> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  removeThisProduct() {
    Product.removeFromFavorites(widget.product.id);
    setState(() {});
  }

  _buildBody() {
    if (widget.quantity <= 0) {
      return const SizedBox(width: 10, height: 10);
    }
    List<Widget> listOfButtons = [];
    var size = MediaQuery.of(context).size;
    var width = size.width * .9;
    var height = size.height;
    if (widget.typeOfPage == ShoppingCartProduct.favorites) {
      Color pinkHeart = const Color.fromARGB(255, 255, 57, 126);
      listOfButtons = [
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: removeThisProduct,
            child: Icon(
              Icons.favorite,
              color: pinkHeart,
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () => Product.addToCart(widget.product.id),
            child: const Icon(Icons.add_shopping_cart))
      ];
    } else if (widget.typeOfPage == ShoppingCartProduct.history) {
      String formatter = DateFormat('yMd').format(widget.product.orderedDate!);
      listOfButtons = [
        Center(
          child: Text(
            'Purchased the: ' + formatter,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ];
    } else {
      listOfButtons = _listOfButtons(width);
    }
    var paddingWidth = min(width * 0.01, 20) as double;
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Colors.black.withOpacity((0))),
          shadowColor: MaterialStateProperty.all(Colors.black.withOpacity((0))),
        ),
        onPressed: () => Navigator.push(
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
                        padding: EdgeInsets.all(paddingWidth),
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
                                  color: Colors.black,
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: productPriceSize),
                            )
                          ])),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: listOfButtons,
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
                      color: Colors.black,
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
