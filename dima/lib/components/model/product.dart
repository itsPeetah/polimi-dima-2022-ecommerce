import 'package:flutter/cupertino.dart';

class Product {
  final Image image;
  final String name;
  final String price;

  Product({required this.image, required this.name, required this.price});

  factory Product.fromRTDB(Map<String, dynamic> data) {
    return Product(
        image: Image.network(data['link']),
        name: data['name'],
        price: data['price'].toString() + '\$');
  }
}
