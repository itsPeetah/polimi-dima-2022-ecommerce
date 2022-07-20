import '../../model/product.dart';

Map<String, dynamic> parseContent(Map<String, dynamic> map) {
  Map<String, dynamic> parsed = <String, dynamic>{};
  for (var p in map.values) {
    Product product = Product.fromRTDB(p);
    parsed[product.id] = product;
  }
  return parsed;
}

Map<String, dynamic> stringifyContent(Map<String, dynamic> map) {
  Map<String, dynamic> stringified = <String, dynamic>{};

  for (Product p in map.values) {
    stringified[p.id] =
        Product.toRTDB(p, quantity: p.qty, orderedDate: p.orderedDate);
  }

  return stringified;
}
