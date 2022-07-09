import 'dart:math';

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
    return LayoutBuilder(builder: (context, constraints) {
      return _buildBody(constraints);
    });
  }

  removeThisProduct() {
    Product.removeFromFavorites(widget.product.id);
    setState(() {});
  }

  _buildBody(BoxConstraints constraints) {
    if (widget.quantity <= 0) {
      return const SizedBox(width: 10, height: 10);
    }
    List<Widget> listOfButtons = [];
    var size = MediaQuery.of(context).size;
    final _maxWidth = constraints.maxWidth;
    final _maxHeight = constraints.maxHeight;
    var textAlignment = TextAlign.center;
    var _alignment = MainAxisAlignment.center;
    var _imageFlex = 1;
    var _textFlex = 1;
    var _buttonFlex = 1;
    var _tileHeight = min(_maxHeight, 260).toDouble();
    var _tileWidth = _maxWidth;
    var _crossAxisAlignment = CrossAxisAlignment.center;
    if (_maxWidth >= tabletWidth) {
      textAlignment = TextAlign.left;
      _imageFlex = 3;
      _textFlex = 5;
      _buttonFlex = 2;
      _tileHeight = _maxHeight * 0.8;
      _tileWidth = _maxWidth;
      _alignment = MainAxisAlignment.center;
      _crossAxisAlignment = CrossAxisAlignment.start;
    }
    // var width = size.width * 0.9;
    var height = size.height * 1;
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
      listOfButtons = _listOfButtons(_maxWidth);
    }
    var paddingWidth = min(height * 0.06, 6).toDouble();
    var _buttonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.black.withOpacity((0))),
      shadowColor: MaterialStateProperty.all(Colors.black.withOpacity((0))),
    );
    Expanded image = Expanded(
      flex: _imageFlex,
      child: Padding(
        padding: EdgeInsets.only(left: paddingWidth),
        child: SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.contain,
            child: widget.product.image,
          ),
        ),
      ),
    );
    Expanded ex2 = Expanded(
      flex: _textFlex,
      child: SizedBox(
        height: _tileHeight,
        child: Column(
          mainAxisAlignment: _alignment,
          crossAxisAlignment: _crossAxisAlignment,
          children: [
            ProductTitleCard(
              text: widget.product.name,
              alignment: textAlignment,
            ),
            Text(
              widget.product.price,
              textAlign: textAlignment,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Raleway-Regular',
                  fontSize: productPriceSize),
            )
          ],
        ),
      ),
    );
    Expanded buttons = Expanded(
      flex: _buttonFlex,
      child: SizedBox(
        height: _tileHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: listOfButtons,
        ),
      ),
    );
    return ElevatedButton(
      style: _buttonStyle,
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductFromID(product: widget.product))),
      child: Container(
        height: _tileHeight,
        width: _tileWidth,
        color: backgroundItemColor1,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text('FUCK')
            image,
            ex2,
            buttons
          ],
        ),
      ),
    );
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
