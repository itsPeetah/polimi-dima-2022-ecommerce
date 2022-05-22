import 'package:dima/model/product.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Shop {
  Shop({
    required this.name,
    required this.coords,
    required this.products,
  });

  final String name;
  final LatLng coords;
  final List<String> products;

  factory Shop.fromRTDB(Map<String, dynamic> data) {
    // return Shop(coords: LatLng(0, 0), name: 'Test', products: ['0', '1']);
    List<String> listOfProductIDs = [];
    if (data['products'] != null) {
      List<Object?> products = data['products'];

      for (var key in products) {
        listOfProductIDs.add(key.toString());
      }
    }
    return Shop(
        name: data['name'],
        coords: LatLng(data['location']['lat'] as double,
            data['location']['long'] as double),
        products: listOfProductIDs);
  }
}
