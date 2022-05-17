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
}
