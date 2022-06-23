import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/product.dart';
import '../database/database.dart';

class CartManager {
  static CartManager instance = CartManager();
  late Map<String, dynamic> content;

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonStr = prefs.getString("localCart");

    if (jsonStr == null) {
      content = <String, dynamic>{};
    } else {
      content = jsonDecode(jsonStr) as Map<String, dynamic>;
    }
  }

  // gateway to cart -> if logged use dbmanager, if not use this

  Map<String, dynamic> getItems() {
    if (FirebaseAuth.instance.currentUser != null) {
      return DatabaseManager.cart as Map<String, dynamic>;
    } else {
      return content;
    }
  }

  void addToCart(String productId) {
    if (FirebaseAuth.instance.currentUser != null) {
      _addToCartRemote(productId);
    } else {
      _addToCartLocal(productId);
    }
  }

  void removeFromCart(String productId) {
    if (FirebaseAuth.instance.currentUser != null) {
      _removeFromCartRemote(productId);
    } else {
      _removeFromCartLocal(productId);
    }
  }

  // REMOTE CART (LOGGED IN)

  void _addToCartRemote(String productId) {
    Product? oldProd = DatabaseManager.cart[productId];
    if (oldProd == null) {
      oldProd = DatabaseManager.allProducts[productId];
      oldProd!.qty = 0;
    }
    oldProd.qty = oldProd.qty + 1;
    DatabaseManager.updateUserCartFromProduct(oldProd);
  }

  void _removeFromCartRemote(String productId) {
    Product oldProd = DatabaseManager.cart[productId];
    oldProd.qty = oldProd.qty - 1;
    DatabaseManager.updateUserCartFromProduct(oldProd);
  }

  // LOCAL CART (NOT LOGGED IN)

  void _addToCartLocal(String productId) {
    Product? oldProd = content[productId];
    if (oldProd == null) {
      oldProd = DatabaseManager.allProducts[productId];
      oldProd!.qty = 0;
    }
    oldProd.qty = oldProd.qty + 1;
    content[productId] = oldProd;
    _saveLocalCart();
  }

  void _removeFromCartLocal(String productId) {
    Product oldProd = content[productId];
    oldProd.qty = oldProd.qty - 1;
    content[productId] = oldProd;
    _saveLocalCart();
  }

  void _saveLocalCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(content);
    await prefs.setString("localCart", jsonString);
  }
}
