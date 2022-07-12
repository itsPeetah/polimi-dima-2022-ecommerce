import 'dart:convert';

import 'package:dima/main.dart';
import 'package:dima/util/user/product_map_prefs_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/product.dart';
import '../database/database.dart';

class CartManager {
  static const String _PREFSKEY = "localCart";

  static CartManager instance = CartManager();
  late Map<String, dynamic> content;

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonStr = prefs.getString(_PREFSKEY);

    if (jsonStr == null) {
      content = <String, dynamic>{};
    } else {
      // content = jsonDecode(jsonStr) as Map<String, dynamic>;
      content = parseContent(jsonDecode(jsonStr) as Map<String, dynamic>);
    }
  }

  // gateway to cart -> if logged use dbmanager, if not use this

  Map<String, dynamic> getItems() {
    if (ApplicationState.isTesting ||
        FirebaseAuth.instance.currentUser != null) {
      print('DBM.CART:' + DatabaseManager.cart.entries.toString());
      return DatabaseManager.cart as Map<String, dynamic>;
    } else {
      return content;
    }
  }

  void addToCart(String productId) {
    if (ApplicationState.isTesting) {
      Product oldProd = DatabaseManager.cart[productId];
      oldProd.qty = oldProd.qty + 1;
      DatabaseManager.updateUserCartFromProduct(oldProd, save: false);
      return;
    }
    if (FirebaseAuth.instance.currentUser != null) {
      _addToCartRemote(productId);
    } else {
      _addToCartLocal(productId);
    }
  }

  void removeFromCart(String productId) {
    if (ApplicationState.isTesting) {
      Product oldProd = DatabaseManager.cart[productId];
      oldProd.qty = 0;
      DatabaseManager.updateUserCartFromProduct(oldProd, save: false);
      return;
    }
    if (FirebaseAuth.instance.currentUser != null) {
      _removeFromCartRemote(productId);
    } else {
      _removeFromCartLocal(productId);
    }
  }

  void emptyCart() {
    if (FirebaseAuth.instance.currentUser != null) {
      _emptyCartRemote();
    } else {
      _emptyCartLocal();
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
    DatabaseManager.updateUserCartFromProduct(oldProd, save: false);
  }

  void _removeFromCartLocal(String productId) {
    Product oldProd = content[productId];
    oldProd.qty = oldProd.qty - 1;
    content[productId] = oldProd;
    _saveLocalCart();
    DatabaseManager.updateUserCartFromProduct(oldProd, save: false);
  }

  void _emptyCartRemote() {
    DatabaseManager.emptyCart();
  }

  void _emptyCartLocal() {
    // TODO Notify listeners (also on favs and history)
    content = <String, dynamic>{};
    _saveLocalCart();
    DatabaseManager.emptyCart(save: false);
  }

  void _saveLocalCart() async {
    final prefs = await SharedPreferences.getInstance();
    final stringContent = stringifyContent(content);
    final jsonString = jsonEncode(stringContent);
    await prefs.setString(_PREFSKEY, jsonString);
  }
}
