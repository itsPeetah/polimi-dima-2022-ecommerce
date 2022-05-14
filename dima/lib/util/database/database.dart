import 'package:dima/model/product.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseManager {
  static DatabaseReference? _user;
  static DatabaseReference? _product;

  static final Map _allProducts = Map();
  static Map get allProducts => _allProducts;

  static DatabaseReference get user {
    _user ??= FirebaseDatabase.instance.ref().child("/user");
    return _user!;
  }

  static DatabaseReference get product {
    _product ??= FirebaseDatabase.instance.ref().child("/product");
    return _product!;
  }

  static int get productCount => _allProducts.length;

  static void updateProductStore(DataSnapshot dbSnapshot) {
    int counter = 0;
    for (var pData in dbSnapshot.value as List<dynamic>) {
      final productData = Map<String, dynamic>.from(pData);
      final product = Product.fromRTDB(productData);
      _allProducts["$counter"] = product;
      counter++;
    }
  }

  static void updateProduct(DataSnapshot dbSnapshot) {
    final productData = dbSnapshot.value as Map<String, dynamic>;
    final product = Product.fromRTDB(productData);
    _allProducts[dbSnapshot.key] = product;
  }

  static Product? getProduct(String id) {
    if (_allProducts.containsKey(id)) return _allProducts[id];
    return null;
  }
}
