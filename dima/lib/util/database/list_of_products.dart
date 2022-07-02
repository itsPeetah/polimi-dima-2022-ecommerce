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
      listOfWidgets.add(Column(
        children: [
          ShoppingCartProduct(
            product: product,
            quantity: product.qty,
          ),
          const Divider(
            thickness: 2,
            indent: 5,
            endIndent: 5,
            color: dividerColor,
          )
        ],
      ));
    }
  }
  return listOfWidgets;
}

List<Widget> getItemsOnly(_maxHeight) {
  Map<String, dynamic> productAsMap =
      DatabaseManager.cart as Map<String, dynamic>;
  List<Widget> listOfWidgets = [];
  for (Product product in productAsMap.values) {
    if (product.qty > 0) {
      listOfWidgets.add(
        ShoppingCartProduct(
          product: product,
          quantity: product.qty,
        ),
      );
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

List<Widget> getItemsInFavorites({bool dividers = true}) {
  Map<String, dynamic> productAsMap =
      DatabaseManager.favorites as Map<String, dynamic>;
  List<Widget> listOfWidgets = [];
  // print('Favorites:: ' + productAsMap.values.toString());
  for (Product product in productAsMap.values) {
    if (product.qty > 0) {
      listOfWidgets.add(ShoppingCartProduct(
        product: product,
        quantity: product.qty,
        typeOfPage: ShoppingCartProduct.favorites,
      ));
      if (dividers) {
        listOfWidgets.add(const Divider(
          thickness: 2,
          indent: 5,
          endIndent: 5,
          color: dividerColor,
        ));
      }
    }
  }
  return listOfWidgets;
}

List<Widget> getItemsInBought({bool dividers = true}) {
  Map<String, dynamic> productAsMap =
      DatabaseManager.bought as Map<String, dynamic>;
  List<Widget> listOfWidgets = [];

  // print('Boughtss:: ' + productAsMap.values.toString());
  for (Product product in productAsMap.values) {
    if (product.qty > 0) {
      listOfWidgets.add(ShoppingCartProduct(
        product: product,
        quantity: product.qty,
        typeOfPage: ShoppingCartProduct.history,
      ));
      if (dividers) {
        listOfWidgets.add(const Divider(
          thickness: 2,
          indent: 5,
          endIndent: 5,
          color: dividerColor,
        ));
      }
    }
  }
  return listOfWidgets;
}
