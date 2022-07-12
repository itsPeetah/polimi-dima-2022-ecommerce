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
  static DatabaseReference? _favoritesRef;
  static DatabaseReference? _boughtRef;
  static DatabaseReference? _numTransactionsRef;

  static final Map _allProducts = <String, dynamic>{};
  static Map get allProducts => _allProducts;

  static final Map _allShops = <String, dynamic>{};
  static Map get allShops => _allShops;

  static final Map _cart = <String, dynamic>{};
  static Map get cart => _cart;

  static final Map _favorites = <String, dynamic>{};
  static Map get favorites => _favorites;

  static final Map _bought = <String, dynamic>{};
  static Map get bought => _bought;

  static int? _numTransactions;
  static int get numTransactions => _numTransactions!;

  static DatabaseReference get users {
    _users ??= FirebaseDatabase.instance.ref().child("/user");
    return _users!;
  }

  static DatabaseReference get userCart {
    _userCart ??= FirebaseDatabase.instance.ref().child(
        '/user' + '/' + FirebaseAuth.instance.currentUser!.uid + '/cart');
    return _userCart!;
  }

  static DatabaseReference get favoritesRef {
    _favoritesRef ??= FirebaseDatabase.instance.ref().child(
        '/user' + '/' + FirebaseAuth.instance.currentUser!.uid + '/favorites');
    return _favoritesRef!;
  }

  static DatabaseReference get numTransactionsRef {
    _numTransactionsRef ??= FirebaseDatabase.instance.ref().child('/user' +
        '/' +
        FirebaseAuth.instance.currentUser!.uid +
        '/numTransactions');
    return _numTransactionsRef!;
  }

  static DatabaseReference get boughtRef {
    _boughtRef ??= FirebaseDatabase.instance.ref().child(
        '/user' + '/' + FirebaseAuth.instance.currentUser!.uid + '/bought');
    return _boughtRef!;
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

  static void initUserCart(DataSnapshot dbSnapshot) {
    if (dbSnapshot.value == null) {
      // print('No data in user cart');
      return;
    }
    if (jsonDecode(jsonEncode(dbSnapshot.value)) is! Map<String, dynamic>) {
      // print('Init user cart instance is not Map string dynamic');
      return;
    }
    Map<String, dynamic> prodMap = jsonDecode(jsonEncode(dbSnapshot.value));

    for (var pKey in prodMap.keys) {
      final product = Product.fromRTDB(prodMap[pKey]);
      if (product.qty > 0) {
        _cart[product.id] = product;
      }
    }
  }

  static void initFavorites(DataSnapshot dbSnapshot) {
    if (dbSnapshot.value == null) {
      // print('No data in user initFavorites');
      return;
    }
    if (jsonDecode(jsonEncode(dbSnapshot.value)) is! Map<String, dynamic>) {
      // print('initFavorites is not Map string dynamic');
      return;
    }
    Map<String, dynamic> prodMap = jsonDecode(jsonEncode(dbSnapshot.value));

    for (var pKey in prodMap.keys) {
      final product = Product.fromRTDB(prodMap[pKey]);
      if (product.qty > 0) {
        _favorites[product.id] = product;
      }
    }
  }

  static void initUserHistory(DataSnapshot dbSnapshot) {
    if (dbSnapshot.value == null) {
      // print('No data in user history');
      return;
    }

    if (jsonDecode(jsonEncode(dbSnapshot.value)) is List) {
      List<dynamic> listProdMap = jsonDecode(jsonEncode(dbSnapshot.value));
      // print(listProdMap);
      List<dynamic> filteredList = [];
      for (var map in listProdMap) {
        if (map != null) {
          filteredList.add(map);
        }
      }
      int j = 0;
      for (Map<String, dynamic> prodMap in filteredList) {
        _bought[j.toString()] = Product.fromRTDB(prodMap);
        j++;
      }
      if (j != _numTransactions) {
        // print(
        //     'Error not enough products in the user history to be equal to the history list');
        // print(j.toString());
        // print('NUM TRANS: ' + _numTransactions.toString());
      }
      return;
    }
    Map<String, dynamic> prodMap = jsonDecode(jsonEncode(dbSnapshot.value));

    for (var pKey in prodMap.keys) {
      final product = Product.fromRTDB(prodMap[pKey]);
      if (product.qty > 0) {
        _favorites[product.id] = product;
      }
    }
  }

  static void initUserTransactions(DataSnapshot dbSnapshot) {
    _numTransactions = jsonDecode(jsonEncode(dbSnapshot.value));
    _numTransactions ??= 0;
  }

  //////          Getters         //////
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

  //////        UPDATERS          /////
  static void updateProductStore(DataSnapshot dbSnapshot) {
    List<dynamic> dataList = jsonDecode(jsonEncode(dbSnapshot.value));
    for (var pData in dataList) {
      final productData = Map<String, dynamic>.from(pData);
      final product = Product.fromRTDB(productData);
      _allProducts[product.id] = product;
    }
  }

  static void updateFavorites(DataSnapshot dbSnapshot) {
    Map<String, dynamic> prodMap = jsonDecode(jsonEncode(dbSnapshot.value));

    final product = Product.fromRTDB(prodMap);
    if (product.qty > 0) {
      _favorites[product.id] = product;
    }
  }

  static void updateUserCart(DataSnapshot dbSnapshot) {
    Map<String, dynamic> prodMap = jsonDecode(jsonEncode(dbSnapshot.value));

    final product = Product.fromRTDB(prodMap);
    if (product.qty > 0) {
      _cart[product.id] = product;
    }
  }

  static void updateUserCartFromProduct(Product product, {save = true}) {
    _cart[product.id] = product;
    if (save == false) return;
    _userCart!
        .child('/' + product.name)
        .update(Product.toRTDB(product, quantity: product.qty));
  }

  static void updateUserHistoryFromProduct(Product product, {save = true}) {
    // print('updateUserHistoryFromProduct got product: ' + product.toString());
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);

    _bought[_numTransactions!.toString()] = Product.fromRTDB(
        Product.toRTDB(product, quantity: product.qty, orderedDate: date));
    if (save == false) return;
    _boughtRef!
        // define random key
        .child('/' + _numTransactions!.toString() + '/')
        .set(Product.toRTDB(product, quantity: product.qty, orderedDate: date));
    _numTransactions = _numTransactions! + 1;
    _numTransactionsRef!.set(_numTransactions);
  }

  static void updateFavoritesFromProduct(Product product, {save = true}) {
    _favorites[product.id] = product;
    if (save == false) return;
    _favoritesRef!
        .child('/' + product.name)
        .update(Product.toRTDB(product, quantity: product.qty));
  }

  static void emptyCart({save = true}) {
    for (Product product in _cart.values) {
      product.qty = 0;
      _cart[product.id] = product;
      if (save) {
        _userCart!
            .child('/' + product.name)
            .update(Product.toRTDB(product, quantity: product.qty));
      }
    }
  }

  static void updateProduct(DataSnapshot dbSnapshot) {
    final productData = jsonDecode(jsonEncode(dbSnapshot.value));
    final product = Product.fromRTDB(productData);
    _allProducts[dbSnapshot.key] = product;
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

  static setShops(DataSnapshot dbSnapshot) {}

  static void updateProductTester() {
    final product = Product.fromTest();
    _allProducts['0'] = product;
  }

  static void updateShopTester() {
    final product = Shop.fromTest();
    _allProducts['0'] = product;
    allProducts['0'] = _allProducts['0'];
  }

  static void updateCartTester() {
    updateProductTester();
    _cart['0'] = _allProducts['0'];
    cart['0'] = _cart['0'];
  }
}
