import 'dart:convert';

import 'package:dima/main.dart';
import 'package:dima/util/user/product_map_prefs_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/product.dart';
import '../database/database.dart';

class PurchaseHistoryManager {
  static const String _PREFSKEY_HISTORY = "localPurchaseHistory";
  static const String _PREFSKEY_NUMTRANS = "localNumTransactions";

  static PurchaseHistoryManager instance = PurchaseHistoryManager();
  late Map<String, dynamic> content;
  int numTransactions = 0;

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonStr = prefs.getString(_PREFSKEY_HISTORY);
    final int? integer = prefs.getInt(_PREFSKEY_NUMTRANS);

    if (jsonStr == null) {
      content = <String, dynamic>{};
    } else {
      // content = jsonDecode(jsonStr1) as Map<String, dynamic>;
      content = parseContent(jsonDecode(jsonStr) as Map<String, dynamic>);
    }

    if (integer == null) {
      numTransactions = 0;
    } else {
      numTransactions = integer;
    }
  }

  Map<String, dynamic> getItems() {
    if (ApplicationState.isTesting ||
        FirebaseAuth.instance.currentUser != null) {
      return DatabaseManager.bought as Map<String, dynamic>;
    } else {
      return content;
    }
  }

  int getNumTransactions() {
    if (ApplicationState.isTesting ||
        FirebaseAuth.instance.currentUser != null) {
      return DatabaseManager.numTransactions;
    } else {
      return numTransactions;
    }
  }

  void addToPurchaseHistory(Product product) {
    if (FirebaseAuth.instance.currentUser != null) {
      _addToPurchaseHistoryRemote(product);
    } else {
      _addToPurchaseHistoryLocal(product);
    }
  }

  // void removeFromPurchaseHistory(String productId) {
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     _removeFromPurchaseHistoryRemote(productId);
  //   } else {
  //     _removeFromPurchaseHistoryLocal(productId);
  //   }
  // }

  // REMOTE CART (LOGGED IN)

  void _addToPurchaseHistoryRemote(Product product) {
    DatabaseManager.updateUserHistoryFromProduct(product);
  }

  // void _removeFromPurchaseHistoryRemote(String productId) {
  //   Product oldProd = DatabaseManager.cart[productId];
  //   oldProd.qty = oldProd.qty - 1;
  //   DatabaseManager.updateUserCartFromProduct(oldProd);
  // }

  // LOCAL CART (NOT LOGGED IN)

  void _addToPurchaseHistoryLocal(Product product) {
    //
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    String key = numTransactions.toString();
    numTransactions += 1;

    content[key] = Product.fromRTDB(
        Product.toRTDB(product, quantity: product.qty, orderedDate: date));

    _saveLocalPurchaseHistory();

    DatabaseManager.updateUserHistoryFromProduct(product, save: false);
  }

  // void _removeFromPurchaseHistoryLocal(String productId) {
  //   Product oldProd = content[productId];
  //   oldProd.qty = oldProd.qty - 1;
  //   content[productId] = oldProd;
  //   _saveLocalPurchaseHistory();
  // }

  void _saveLocalPurchaseHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final stringContent = stringifyContent(content);
    final jsonString = jsonEncode(stringContent);
    await prefs.setString(_PREFSKEY_HISTORY, jsonString);
    await prefs.setInt(_PREFSKEY_NUMTRANS, numTransactions);
  }
}
