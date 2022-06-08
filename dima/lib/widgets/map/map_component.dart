import 'package:dima/styles/styleoftext.dart';
import 'package:dima/widgets/product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../model/shop.dart';
import '../../util/database/database.dart';

class MapContainer extends StatefulWidget {
  const MapContainer({Key? key, required this.parentSetState})
      : super(key: key);
  final Function parentSetState;
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapContainer> {
  late GoogleMapController mapController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;

  void _onShopTapped(MarkerId markerId) {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        final MarkerId? previousMarkerId = selectedMarker;
        if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
          final Marker resetOld = markers[previousMarkerId]!
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[previousMarkerId] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange,
          ),
        );
        markers[markerId] = newMarker;

        // markerPosition = null;
      });
    }
  }

  void _add(
      {latOffset = 0,
      longOffset = 0,
      shopName = 'Shop Name #1',
      description = 'Short Description for shop'}) {
    var markerIdVal = shopName;
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        _center.latitude + latOffset,
        _center.longitude + longOffset,
      ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: description),
      onTap: () {
        _onShopTapped(markerId);
        widget.parentSetState();
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  final LatLng _center = const LatLng(45.464664, 9.188540);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _add();
    _add(latOffset: 0.015, longOffset: -0.015, shopName: 'LV');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return _createBody(constraints);
    });
  }

  Widget _createBody(BoxConstraints constraints) {
    List<Widget> relatedProducts;
    if (selectedMarker != null) {
      relatedProducts = [
        Center(
          child: Text(
              'Shop position:' + markers[selectedMarker]!.position.toString()),
        ),
        const Center(
          child: Text('Shop products:'),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.35,
          width: constraints.maxWidth * 0.85,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _getShopProducts(),
          ),
        )
      ];
    } else {
      relatedProducts = const [SizedBox.shrink()];
    }
    List<Widget> allChildren = [
      const Center(child: Headline(text: 'All the shops close to you')),
      Center(
        child: Padding(
          padding: EdgeInsets.all(constraints.maxWidth * 0.06),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: constraints.maxWidth < 600 ? 4 : 8,
                  color: borderColor),
            ),
            child: SizedBox(
              height: constraints.maxHeight * 0.50,
              width: constraints.maxWidth * 0.8,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                markers: Set.from(markers.values),
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            ),
          ),
        ),
      ),
    ];
    allChildren.addAll(relatedProducts);
    return ListView(
      scrollDirection: Axis.vertical,
      children: allChildren,
    );
  }

  List<Widget> _getShopProducts() {
    /// TODO: add check that firebase is available and Change shop name from constant to something else
    // if (!appState.firebaseAvailable) {
    //   return <Widget>[];
    // }
    Shop? shop = DatabaseManager.getShop('Luigi Vitonno');
    List<Widget> listOfProducts = [];
    for (var productId in shop!.products) {
      listOfProducts.add(SizedBox(
          width: 300,
          height: 250,
          child: ProductCard(
            productId: productId,
          )));
    }
    return listOfProducts;
  }
}
