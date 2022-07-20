import 'package:dima/model/product.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseManager {
  static bool isInitialized = false;

  static DatabaseReference? productRef;
  static DatabaseReference? userRef;

  void init() {
    productRef = FirebaseDatabase.instance.ref().child('/product');
    userRef = FirebaseDatabase.instance.ref().child('/user');

    isInitialized = true;

    // callback
  }
}

query(String s) async {
  var resultList = (await getAllDb()).where((Product product) =>
      (product.name.toLowerCase()).contains(s.toLowerCase()));
  return resultList;
}

getProductInfo(String productId) {
  return query(productId);
}

Future<List<Product>> userPref() async {
  List<Product> result = await getAllDb();
  return result.sublist(0, 3);
}

Future<List<Product>> getAllDb() async {
  List<Product> resultList = [];

  // await Future.delayed(const Duration(milliseconds: 100), () {});
  // print('get all db call');
  // final productRef = FirebaseDatabase.instance.ref().child('/product');
  // productRef.orderByKey().limitToFirst(10).onValue.listen(
  //   (event) {
  //     List<Product> resultList = [];
  //     final listOfData = event.snapshot.value as List<dynamic>;
  //     for (Map<dynamic, dynamic> data in listOfData) {
  //       var datax = Map<String, dynamic>.from(data);
  //       final productToAppend = Product.fromRTDB(datax);
  //       resultList.add(productToAppend);
  //       // set state
  //     }
  //   },
  // );

  return resultList;
}

// getProductFromId(String id) {
//   List<Map<String, String>> res = getAllDb();
//   //print("Is true?: - " + res.containsValue(id).toString());
//   var result = res.where((element) => element['id'] == id);
//   if (result.first.isEmpty) {
//     throw Exception("Can not find product with id:" + id);
//   } else {
//     return result.first;
//   }
// }
