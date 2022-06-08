import 'package:dima/model/product.dart';
import 'package:dima/util/database/database.dart';
import 'package:dima/widgets/shopping_cart/shopping_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List<Widget> getItemsInCart() {
  Map<String, dynamic> productAsMap =
      DatabaseManager.cart as Map<String, dynamic>;
  List<Widget> listOfWidgets = [];
  for (Product product in productAsMap.values) {
    listOfWidgets.add(ShoppingCartProduct(
      product: product,
      quantity: product.qty,
      parentRebuild: () => {},
    ));
    listOfWidgets.add(const Divider());
  }
  return listOfWidgets;
}
