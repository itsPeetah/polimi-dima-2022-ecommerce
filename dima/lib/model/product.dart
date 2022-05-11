import 'package:flutter/cupertino.dart';

class Product {
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
      'quantity': quantity + 1
    };
    return result;
  }
}
