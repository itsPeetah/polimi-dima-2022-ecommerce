import 'package:flutter/cupertino.dart';

class Product {
  final Image image;
  final String name;
  final String price;
  final String imageLink;

  Product(
      {required this.image,
      required this.name,
      required this.price,
      required this.imageLink});

  factory Product.fromRTDB(Map<String, dynamic> data) {
    return Product(
        image: Image.network(data['link']),
        imageLink: data['link'],
        name: data['name'],
        price: data['price'].toString() + '\$');
  }

  static Map<String, dynamic> toRTDB(Product p, {int quantity = 0}) {
    Map<String, dynamic> result = {
      'link': p.imageLink,
      'name': p.name,
      'price': p.price,
      'quantity': quantity + 1
    };
    return result;
  }
}
