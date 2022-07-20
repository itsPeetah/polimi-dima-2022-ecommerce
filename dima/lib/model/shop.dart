import 'package:google_maps_flutter/google_maps_flutter.dart';

class Shop {
  Shop({
    required this.name,
    required this.coords,
    required this.products,
    required this.description,
  });

  final String name;
  final LatLng coords;
  final List<String> products;
  final String description;

  factory Shop.fromRTDB(Map<String, dynamic> data) {
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
        products: listOfProductIDs,
        description: data['description']);
  }

  factory Shop.fromTest() {
    return Shop(
      name: 'Luigi Vitonno',
      description: 'Lorem Ipsum',
      products: ['0'],
      coords: LatLng(45.0, 9.0),
    );
  }
}
