import 'package:flutter/material.dart';
import '../widgets/map/map_component.dart';
import 'misc/fork.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ForkPage(title: "home", route1: "/map", route2: "/profile"),
        MapContainer()
      ],
    );
  }
}
