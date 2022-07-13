import 'dart:convert';

import 'package:dima/main.dart';
import 'package:dima/util/user/product_map_prefs_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/product.dart';
import '../database/database.dart';

class FavoritesManager {
  static const String _PREFSKEY = "localFavorites";

  static FavoritesManager instance = FavoritesManager();
  late Map<String, dynamic> content;
  Function? notify;
  void init(Function? fn) async {
    if (fn != null) {
      notify = fn;
    }
    final prefs = await SharedPreferences.getInstance();
    final String? jsonStr = prefs.getString(_PREFSKEY);

    if (jsonStr == null) {
      content = <String, dynamic>{};
    } else {
      // content = jsonDecode(jsonStr) as Map<String, dynamic>;
      content = parseContent(jsonDecode(jsonStr) as Map<String, dynamic>);
    }
  }

  Map<String, dynamic> getItems() {
    if (ApplicationState.isTesting ||
        FirebaseAuth.instance.currentUser != null) {
      return DatabaseManager.favorites as Map<String, dynamic>;
    } else {
      return content;
    }
  }

  void addToFavorites(String productId) {
    if (FirebaseAuth.instance.currentUser != null) {
      _addToFavoritesRemote(productId);
    } else {
      _addToFavoritesLocal(productId);
      notify!();
    }
  }

  void removeFromFavorites(String productId) {
    if (FirebaseAuth.instance.currentUser != null) {
      _removeFromFavoritesRemote(productId);
    } else {
      _removeFromFavoritesLocal(productId);
      notify!();
    }
  }

  // REMOTE CART (LOGGED IN)

  void _addToFavoritesRemote(String productId) {
    Product prod = DatabaseManager.allProducts[productId];
    prod.qty = 1;
    DatabaseManager.updateFavoritesFromProduct(prod);
  }

  void _removeFromFavoritesRemote(String productId) {
    Product prod = DatabaseManager.allProducts[productId];
    prod.qty = 0;
    DatabaseManager.updateFavoritesFromProduct(prod);
  }

  // LOCAL CART (NOT LOGGED IN)

  void _addToFavoritesLocal(String productId) {
    Product prod = DatabaseManager.allProducts[productId];
    prod.qty = 1;
    content[productId] = prod;
    _saveLocalCart();
    DatabaseManager.updateFavoritesFromProduct(prod, save: false);
  }

  void _removeFromFavoritesLocal(String productId) {
    Product prod = DatabaseManager.allProducts[productId];
    prod.qty = 0;
    content[productId] = prod;
    _saveLocalCart();
    DatabaseManager.updateFavoritesFromProduct(prod, save: false);
  }

  void _saveLocalCart() async {
    final prefs = await SharedPreferences.getInstance();
    final stringContent = stringifyContent(content);
    final jsonString = jsonEncode(stringContent);
    await prefs.setString(_PREFSKEY, jsonString);
  }
}
