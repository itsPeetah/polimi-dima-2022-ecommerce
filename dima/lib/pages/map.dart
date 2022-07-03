import 'package:flutter/material.dart';
import '../widgets/map/map_component.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: const [
        Expanded(flex: 3, child: MapContainer()),
      ],
    );
  }
}
