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

  static void addToCart(String productId) {
    Product? oldProd = DatabaseManager.cart[productId];
    if (oldProd == null) {
      oldProd = DatabaseManager.allProducts[productId];
      oldProd!.qty = 0;
    }
    oldProd.qty = oldProd.qty + 1;
    DatabaseManager.updateUserCartFromProduct(oldProd);
    return;
  }

  static void removeFromCart(String productId) {
    Product oldProd = DatabaseManager.cart[productId];
    oldProd.qty = oldProd.qty - 1;
    DatabaseManager.updateUserCartFromProduct(oldProd);
    return;
  }

  @override
  String toString() {
    return 'Name: ' +
        name +
        ', Price: ' +
        price +
        ', Quantity: ' +
        qty.toString();
  }
}
