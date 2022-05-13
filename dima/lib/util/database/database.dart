import 'package:firebase_database/firebase_database.dart';

class DatabaseManager {
  static DatabaseReference? _user;
  static DatabaseReference? _product;

  static DatabaseReference get user {
    _user ??= FirebaseDatabase.instance.ref().child("/user");
    return _user!;
  }

  static DatabaseReference get product {
    _product ??= FirebaseDatabase.instance.ref().child("/product");
    return _product!;
  }
}
