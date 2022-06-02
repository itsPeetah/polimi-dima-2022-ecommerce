import 'package:dima/util/database/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Product {
  final String id;
  final Image image;
  final String name;
  final String price;
  final String imageLink;
  int qty;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.image,
      required this.imageLink,
      this.qty = 0});

  factory Product.fromRTDB(Map<String, dynamic> data) {
    int quantity = 0;
    if (data['quantity'] != null) {
      quantity = data['quantity'];
    }
    return Product(
        id: data['id'].toString(),
        image: Image.network(data['link']),
        imageLink: data['link'],
        name: data['name'],
        price: data['price'].toString() + '\$',
        qty: quantity);
  }

  static Map<String, dynamic> toRTDB(Product p, {int quantity = 0}) {
    Map<String, dynamic> result = {
      'id': p.id,
      'link': p.imageLink,
      'name': p.name,
      'price': p.price.substring(0, p.price.length - 1),
      'quantity': quantity
    };
    return result;
  }

  static Future<void> addToCart(String productId) async {
    User? thisUser = FirebaseAuth.instance.currentUser;

    // TODO Null check?
    // Use id, fetch product data from database
    Product p = DatabaseManager.getProduct(productId)!;

    final userFavoritesRef = DatabaseManager.users
        .child(thisUser!.uid + '/favorites' + '/' + p.name);

    final qt = await userFavoritesRef.child('/quantity').get();
    var quantity = 0;

    if (qt.value != null) {
      quantity = qt.value as int;
    }
    await userFavoritesRef.update(Product.toRTDB(p, quantity: quantity + 1));
  }

  static Future<void> removeFromCart(String productId) async {
    User? thisUser = FirebaseAuth.instance.currentUser;

    // TODO Null check?
    Product p = DatabaseManager.getProduct(productId)!;

    final userFavoritesRef = DatabaseManager.users
        .child(thisUser!.uid + '/favorites' + '/' + p.name);
    final qt = await userFavoritesRef.child('/quantity').get();
    var quantity = 0;

    if (qt.value != null) {
      quantity = qt.value as int;
    }

    if (quantity <= -1) {
      await userFavoritesRef.remove();
    } else {
      await userFavoritesRef.update(Product.toRTDB(p, quantity: quantity - 1));
    }
  }
}
