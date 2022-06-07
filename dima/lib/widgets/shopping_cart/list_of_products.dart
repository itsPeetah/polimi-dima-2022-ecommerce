import 'package:dima/model/product.dart';
import 'package:dima/widgets/shopping_cart/shopping_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<List<Widget>> getItemsInCart() async {
  User? thisUser = FirebaseAuth.instance.currentUser;
  final userFavoritesRef = FirebaseDatabase.instance
      .ref()
      .child('user/' + thisUser!.uid + '/favorites');
  List<Product> listOfItems = [];
  var listOfMapsOfMaps = await userFavoritesRef.orderByKey().once();
  if (listOfMapsOfMaps.snapshot.value == null) {
    return <Widget>[];
  }
  var productAsMap = listOfMapsOfMaps.snapshot.value as Map<String, dynamic>;
  for (var key in productAsMap.keys) {
    var product = Product.fromRTDB(productAsMap[key] as Map<String, dynamic>);
    if (product.qty > 0) {
      listOfItems.add(product);
    }
  }

  List<Widget> listOfWidgets = [];
  for (var product in listOfItems) {
    listOfWidgets.add(ShoppingCartProduct(
      product: product,
      quantity: product.qty,
      parentRebuild: () => {},
    ));
    listOfWidgets.add(const Divider());
  }
  return listOfWidgets;
}
