import 'dart:async';

import 'package:dima/components/product/id.dart';
import 'package:dima/default_scaffold.dart';
import 'package:dima/model/product.dart';
import 'package:dima/styles/styleoftext.dart';
import 'package:dima/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

const NO_BUTTON_PRESSED_CODE = -100;

class ShoppingCartProduct extends StatefulWidget {
  const ShoppingCartProduct(
      {Key? key,
      required this.product,
      required this.quantity,
      required this.parentRebuild})
      : super(key: key);
  final Product product;
  final int quantity;
  final Function parentRebuild;

  @override
  State<ShoppingCartProduct> createState() => ShoppingCartProductState();
}

class ShoppingCartProductState extends State<ShoppingCartProduct> {
  int thisQuantity = NO_BUTTON_PRESSED_CODE;
  Future<void> _addToCart() async {
    User? thisUser = FirebaseAuth.instance.currentUser;
    final userFavoritesRef = FirebaseDatabase.instance.ref().child(
        'user/' + thisUser!.uid + '/favorites' + '/' + widget.product.name);
    final qt = await userFavoritesRef.child('/quantity').once();
    var quantity = 0;

    await Future.delayed(const Duration(milliseconds: 100), () {});
    print('qt.snapshot:' + qt.snapshot.value.toString());
    if (qt.snapshot.value != null) {
      quantity = qt.snapshot.value as int;
    }
    try {
      await userFavoritesRef
          .update(Product.toRTDB(widget.product, quantity: quantity));
    } on Exception catch (exception) {
      print('Add-exception:');
      print(exception);
    }
    widget.parentRebuild();
    setState(() {});
  }

  Future<void> _removeFromCart() async {
    User? thisUser = FirebaseAuth.instance.currentUser;
    final userFavoritesRef = FirebaseDatabase.instance.ref().child(
        'user/' + thisUser!.uid + '/favorites' + '/' + widget.product.name);
    final qt = await userFavoritesRef.child('/quantity').once();
    var quantity = 0;
    print(qt.snapshot.value);
    if (qt.snapshot.value != null) {
      quantity = qt.snapshot.value as int;
    }
    quantity = quantity - 2;

    /// TODO: why error in the get/set calls to database
    await Future.delayed(const Duration(milliseconds: 100), () {});
    print('snap');
    print(qt.snapshot);
    print('0.5 seconds passed');
    if (quantity <= -1) {
      await userFavoritesRef.remove();
    }
    await userFavoritesRef
        .update(Product.toRTDB(widget.product, quantity: quantity));

    widget.parentRebuild();
    setState(() {});
  }

  /// TODO: Implement a callback for the builds. This way we build the parent page for every removed item
  @override
  Widget build(BuildContext context) {
    if (thisQuantity == NO_BUTTON_PRESSED_CODE) {
      thisQuantity = widget.quantity;
    }
    if (thisQuantity == 0) {
      return const SizedBox(width: 0, height: 0);
    }
    var size = MediaQuery.of(context).size;
    var width = size.width * .9;
    var height = size.height;
    var body = GestureDetector(
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
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(width * 0.1, width * 0.05),
                              fixedSize: Size(width * 0.12, width * 0.07)),
                          onPressed: _removeFromCart,
                          child: Icon(
                            Icons.remove,
                            size: width * 0.05,
                          )),
                      SizedBox(
                          width: width / 10,
                          child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 4, bottom: 4),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(50, 255, 255, 255),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: borderColor),
                              ),
                              child: Text(
                                thisQuantity.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: 'Raleway-Regular',
                                    fontSize: productPriceSize),
                              ))),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(width * 0.12, width * 0.07),
                              fixedSize: Size(width * 0.12, width * 0.07)),
                          onPressed: _addToCart,
                          child: Icon(
                            Icons.add,
                            size: width * 0.05,
                          )),
                    ])),
              ],
            )));
    return body;
  }
}
