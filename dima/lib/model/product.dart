import 'package:dima/util/database/database.dart';
import 'package:dima/util/user/cart_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Product {
  final String id;
  Image image;
  final String name;
  final String price;
  final String imageLink;
  DateTime? orderedDate;
  int qty;

  // static final dynamic _loadingBuilder = loadingBuilderFunction;
  static Widget loadingBuilderFunction(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      return child;
    }
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  }

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.image,
      required this.imageLink,
      this.qty = 0,
      this.orderedDate});

  factory Product.fromRTDB(Map<String, dynamic> data) {
    int quantity = 0;
    if (data['quantity'] != null) {
      quantity = data['quantity'];
    }
    if (data['orderedDate'] == null) {
      return Product(
          id: data['id'].toString(),
          image: Image.network(data['link'],
              loadingBuilder: loadingBuilderFunction),
          imageLink: data['link'],
          name: data['name'],
          price: data['price'].toString() + '\$',
          qty: quantity);
    }
    return Product(
        id: data['id'].toString(),
        image:
            Image.network(data['link'], loadingBuilder: loadingBuilderFunction),
        imageLink: data['link'],
        name: data['name'],
        price: data['price'].toString() + '\$',
        qty: quantity,
        orderedDate: DateTime.parse(data['orderedDate']));
  }

  static Map<String, dynamic> toRTDB(Product p,
      {int quantity = 0, DateTime? orderedDate}) {
    Map<String, dynamic> result;
    if (orderedDate == null) {
      result = {
        'id': p.id,
        'link': p.imageLink,
        'name': p.name,
        'price': p.price.substring(0, p.price.length - 1),
        'quantity': quantity
      };
    } else {
      result = {
        'id': p.id,
        'link': p.imageLink,
        'name': p.name,
        'price': p.price.substring(0, p.price.length - 1),
        'quantity': quantity,
        'orderedDate': orderedDate.toString()
      };
    }
    return result;
  }

  static void addToCart(String productId) {
    // Product? oldProd = DatabaseManager.cart[productId];
    // if (oldProd == null) {
    //   oldProd = DatabaseManager.allProducts[productId];
    //   oldProd!.qty = 0;
    // }
    // oldProd.qty = oldProd.qty + 1;
    // DatabaseManager.updateUserCartFromProduct(oldProd);
    // return;
    CartManager.instance.addToCart(productId);
  }

  static void removeFromCart(String productId) {
    // Product oldProd = DatabaseManager.cart[productId];
    // oldProd.qty = oldProd.qty - 1;
    // DatabaseManager.updateUserCartFromProduct(oldProd);
    // return;
    CartManager.instance.removeFromCart(productId);
  }

  static void addToFavorites(String productId) {
    Product? oldProd = DatabaseManager.favorites[productId];
    if (oldProd == null) {
      oldProd = DatabaseManager.allProducts[productId];
      oldProd!.qty = 0;
    }
    oldProd.qty = 1;
    DatabaseManager.updateFavoritesFromProduct(oldProd);
    return;
  }

  static void removeFromFavorites(String productId) {
    Product oldProd = DatabaseManager.favorites[productId];
    oldProd.qty = 0;
    DatabaseManager.updateFavoritesFromProduct(oldProd);
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
