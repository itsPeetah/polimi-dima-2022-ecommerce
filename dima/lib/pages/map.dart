import 'package:dima/pages/misc/fork.dart';
import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ForkPage(
      route1: "/cart",
      route2: "/home",
      title: "Map",
    );
  }
}
