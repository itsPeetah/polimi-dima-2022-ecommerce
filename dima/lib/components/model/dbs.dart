import 'package:dima/components/model/product.dart';
import 'package:firebase_database/firebase_database.dart';

query(String s) {
  var resultList = getAllDb().where((Product product) =>
      (product.name.toLowerCase()).contains(s.toLowerCase()));
  return resultList;
}

getProductInfo(String productId) {
  return query(productId);
}

getElement(int index) {
  if (index >= getAllDb().length) {
    throw Exception(
        "There is no element at required index:" + index.toString());
  } else {
    getAllDb().elementAt(index);
  }
}

fourthChoice() {
  return getAllDb().elementAt(3);
}

List<Product> userPref() {
  List<Product> result = getAllDb();
  if (result.length > 8) {
    result = result.getRange(4, 8).toList();
  } else {
    result = [];
  }
  return result;
}

List<Product> getAllDb() {
  List<Product> resultList = [];
  final productRef = FirebaseDatabase.instance.ref().child('/product');
  productRef.orderByKey().limitToFirst(10).onValue.listen(
    (event) {
      final listOfData = event.snapshot.value as List<dynamic>;
      for (Map<dynamic, dynamic> data in listOfData) {
        var datax = Map<String, dynamic>.from(data);
        final productToAppend = Product.fromRTDB(datax);
        resultList.add(productToAppend);
      }
    },
    onDone: () => resultList,
  );
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
