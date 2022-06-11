import 'package:dima/model/product.dart';
import 'package:dima/styles/styleoftext.dart';
import 'package:dima/util/database/database.dart';
import 'package:dima/widgets/shopping_cart/shopping_product.dart';
import 'package:flutter/material.dart';

List<Widget> getItemsInCart() {
  Map<String, dynamic> productAsMap =
      DatabaseManager.cart as Map<String, dynamic>;
  List<Widget> listOfWidgets = [];
  for (Product product in productAsMap.values) {
    if (product.qty > 0) {
      listOfWidgets.add(ShoppingCartProduct(
        product: product,
        quantity: product.qty,
      ));
      listOfWidgets.add(const Divider(
        thickness: 2,
        indent: 5,
        endIndent: 5,
        color: dividerColor,
      ));
    }
  }
  return listOfWidgets;
}

List<Product> getProductsInCart() {
  Map<String, dynamic> productAsMap =
      DatabaseManager.cart as Map<String, dynamic>;
  List<Product> listOfProducts = [];
  for (Product product in productAsMap.values) {
    listOfProducts.add(product);
  }
  return listOfProducts;
}
