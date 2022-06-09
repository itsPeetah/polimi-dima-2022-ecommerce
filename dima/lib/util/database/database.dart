// ignore_for_file: prefer_adjacent_string_concatenation

import 'dart:convert';

import 'package:dima/model/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../model/shop.dart';

class DatabaseManager {
  static DatabaseReference? _users;
  static DatabaseReference? _product;
  static DatabaseReference? _shop;
  static DatabaseReference? _userCart;

  static final Map _allProducts = <String, dynamic>{};
  static Map get allProducts => _allProducts;

  static final Map _allShops = <String, dynamic>{};
  static Map get allShops => _allShops;

  static final Map _cart = <String, dynamic>{};
  static Map get cart => _cart;

  static DatabaseReference get users {
    _users ??= FirebaseDatabase.instance.ref().child("/user");
    return _users!;
  }

  static DatabaseReference get userCart {
    _userCart ??= FirebaseDatabase.instance.ref().child(
        '/user' + '/' + FirebaseAuth.instance.currentUser!.uid + '/favorites');
    return _userCart!;
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
    List<dynamic> dataList = jsonDecode(jsonEncode(dbSnapshot.value));
    for (var pData in dataList) {
      final productData = Map<String, dynamic>.from(pData);
      final product = Product.fromRTDB(productData);
      _allProducts[product.id] = product;
    }
  }

  static void initUserCart(DataSnapshot dbSnapshot) {
    Map<String, dynamic> prodMap = jsonDecode(jsonEncode(dbSnapshot.value));
    for (var pKey in prodMap.keys) {
      final product = Product.fromRTDB(prodMap[pKey]);
      if (product.qty > 0) {
        _cart[product.id] = product;
      }
    }
  }

  static void updateUserCart(DataSnapshot dbSnapshot) {
    Map<String, dynamic> prodMap = jsonDecode(jsonEncode(dbSnapshot.value));

    final product = Product.fromRTDB(prodMap);
    if (product.qty > 0) {
      _cart[product.id] = product;
    }
  }

  static void updateUserCartFromProduct(Product product) {
    _cart[product.id] = product;
    _userCart!
        .child('/' + product.name)
        .update(Product.toRTDB(product, quantity: product.qty));
  }

  static void updateProduct(DataSnapshot dbSnapshot) {
    final productData = jsonDecode(jsonEncode(dbSnapshot.value));
    final product = Product.fromRTDB(productData);
    _allProducts[dbSnapshot.key] = product;
  }

  static Product getProduct(String id) {
    if (_allProducts.containsKey(id)) {
      return _allProducts[id];
    } else {
      throw Exception(
          "[Database Manager] Could not find product with id '$id'.}");
    }
  }

  static Shop? getShop(String id) {
    if (_allShops.containsKey(id)) return _allShops[id];
    return null;
  }

  static void updateShop(DataSnapshot dbSnapshot) {
    final shopData = jsonDecode(jsonEncode(dbSnapshot.value));
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
