import 'dart:convert';

import 'package:dima/model/product.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../model/shop.dart';

class DatabaseManager {
  static DatabaseReference? _user;
  static DatabaseReference? _product;
  static DatabaseReference? _shop;

  static final Map _allProducts = Map();
  static Map get allProducts => _allProducts;

  static final Map _allShops = Map();
  static Map get allShops => _allShops;

  static DatabaseReference get user {
    _user ??= FirebaseDatabase.instance.ref().child("/user");
    return _user!;
  }

  static DatabaseReference get product {
    _product ??= FirebaseDatabase.instance.ref().child("/product");
    return _product!;
  }

  static DatabaseReference get shop {
    _shop ??= FirebaseDatabase.instance.ref().child("/shop");
    return _shop!;
  }

  static int get productCount => _allProducts.length;

  static void updateProductStore(DataSnapshot dbSnapshot) {
    for (var pData in dbSnapshot.value as List<dynamic>) {
      final productData = Map<String, dynamic>.from(pData);
      final product = Product.fromRTDB(productData);
      _allProducts[product.id] = product;
    }
  }

  static void updateProduct(DataSnapshot dbSnapshot) {
    final productData = dbSnapshot.value
        as Map<String, dynamic>; // TODO Figure out a fix for the exception
    final product = Product.fromRTDB(productData);
    _allProducts[dbSnapshot.key] = product;
  }

  static Product? getProduct(String id) {
    /// TODO: why return null? Just populate the product list and throw exception if no data found
    if (_allProducts.containsKey(id)) return _allProducts[id];
    return null;
  }

  static Shop? getShop(String id) {
    if (_allShops.containsKey(id)) return _allShops[id];
    return null;
  }

  static void updateShop(DataSnapshot dbSnapshot) {
    final shopData = dbSnapshot.value
        as Map<String, dynamic>; // TODO Figure out a fix for the exception
    final shop = Shop.fromRTDB(shopData);
    _allProducts[dbSnapshot.key] = shop;
  }

  static void updateAllShops(DataSnapshot dbSnapshot) {
    for (DataSnapshot sKey in dbSnapshot.children) {
      final shopData = Map<String, dynamic>.from(sKey.value as Map);
      final shop = Shop.fromRTDB(shopData);
      _allShops[shop.name] = shop;
    }
  }

  static setShops(DataSnapshot dbSnapshot) {
    // TODO Implement: add shops to _allShops
  }
}
