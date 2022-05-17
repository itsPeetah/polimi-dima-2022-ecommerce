import 'package:dima/util/database/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Product {
  // final String id; // TODO Add ID!!!
  final Image image;
  final String name;
  final String price;
  final String imageLink;
  int qty;

  Product(
      {required this.image,
      required this.name,
      required this.price,
      required this.imageLink,
      this.qty = 0});

  factory Product.fromRTDB(Map<String, dynamic> data) {
    int quantity = 0;
    if (data['quantity'] != null) {
      quantity = data['quantity'];
    }
    return Product(
        image: Image.network(data['link']),
        imageLink: data['link'],
        name: data['name'],
        price: data['price'].toString() + '\$',
        qty: quantity);
  }

  static Map<String, dynamic> toRTDB(Product p, {int quantity = 0}) {
    Map<String, dynamic> result = {
      'link': p.imageLink,
      'name': p.name,
      'price': p.price.substring(0, p.price.length - 1),
      'quantity': quantity + 1 // TODO FIx this
    };
    return result;
  }

  static Future<void> addToCart(String productId) async {
    User? thisUser = FirebaseAuth.instance.currentUser;

    // TODO Null check?
    Product p = DatabaseManager.getProduct(productId)!;

    final userFavoritesRef =
        DatabaseManager.user.child(thisUser!.uid + '/favorites' + '/' + p.name);

    final qt = await userFavoritesRef.child('/quantity').get();
    var quantity = 0;

    if (qt.value != null) {
      quantity = qt.value as int;
    }
    await userFavoritesRef.update(Product.toRTDB(p, quantity: quantity));
  }
}
