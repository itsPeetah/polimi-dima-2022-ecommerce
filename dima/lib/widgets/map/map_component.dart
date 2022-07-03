import 'dart:async';
import 'dart:math';

import 'package:dima/styles/styleoftext.dart';
import 'package:dima/util/navigation/navigation_nested.dart';
import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:dima/widgets/product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../model/shop.dart';
import '../../util/database/database.dart';

class MapContainer extends StatefulWidget {
  const MapContainer({
    Key? key,
  }) : super(key: key);
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapContainer> {
  late GoogleMapController mapController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;

  Location location = Location();
  late StreamSubscription<LocationData> _locationStream;
  late LocationData _locationData;
  bool rebuild = true;
  Widget? textWidget;
  Widget? _googleMap;

  late double _maxHeight;
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
            BitmapDescriptor.hueAzure,
          ),
        );
        markers[markerId] = newMarker;

        // markerPosition = null;
      });
    }
  }

  void _addAllShops() {
    for (Shop shop in DatabaseManager.allShops.values) {
      _add(
          shopName: shop.name,
          lat: shop.coords.latitude,
          long: shop.coords.longitude,
          description: shop.description);
    }
  }

  void _add(
      {lat = 0,
      long = 0,
      shopName,
      description = 'Short Description for shop'}) {
    var markerIdVal = shopName;
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, long),
      infoWindow: InfoWindow(title: markerIdVal, snippet: description),
      onTap: () {
        _onShopTapped(markerId);
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  LatLng _center = const LatLng(45.4642, 9.1900);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    _getLocation();
    _addAllShops();
    super.initState();
  }

  Future<void> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationStream = location.onLocationChanged.listen((event) {
      _locationData = event;
      _center = LatLng(_locationData.latitude!, _locationData.longitude!);
      // textWidget = Text(_locationText.toString());
      // rebuild the google maps container
      if (rebuild) {
        rebuild = false;
        _googleMap = GoogleMap(
          onMapCreated: _onMapCreated,
          markers: Set.from(markers.values),
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        );
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _locationStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return _createBody(constraints);
    });
  }

  Widget _createBody(BoxConstraints constraints) {
    _maxHeight = constraints.maxHeight;
    var _maxWidth = constraints.maxWidth;
    var _scrollDirection = Axis.horizontal;
    var _scrollHeight = constraints.maxHeight * 0.35;
    var _scrollWidth = constraints.maxWidth * 0.85;
    var _mapHeight = constraints.maxHeight * 0.40;
    var _mapWidth = constraints.maxWidth * 0.9;
    if (_maxWidth >= tabletWidth) {
      _scrollDirection = Axis.vertical;
      _scrollHeight = constraints.maxHeight * 0.89;
      _scrollWidth = constraints.maxWidth * 0.52;
      _mapHeight = constraints.maxHeight * 0.75;
      _mapWidth = constraints.maxWidth * 0.40;
    }
    List<Widget> relatedProducts;
    // Case in which a shop has been pressed and we show all items of shop
    if (selectedMarker != null) {
      relatedProducts = [
        const Text('Products that you find in this shop:',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Merriweather',
              // Merriweather or Lato
            )),
        SizedBox(
          height: _scrollHeight,
          width: _scrollWidth,
          child: ListView(
            scrollDirection: _scrollDirection,
            children: _getShopProducts(),
          ),
        ),
        TextButtonLarge(
          text: 'Find more',
          onPressed: _redirectToShopPage,
        ),
      ];
    } else {
      relatedProducts = const [SizedBox.shrink()];
    }
    _googleMap = GoogleMap(
      onMapCreated: _onMapCreated,
      markers: Set.from(markers.values),
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
    );
    List<Widget> allChildren = [
      Center(
        child: Padding(
          padding: EdgeInsets.all(max(6, constraints.maxWidth * 0.02)),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: constraints.maxWidth < tabletWidth ? 4 : 6,
                  color: borderColor),
            ),
            child: SizedBox(
              height: _mapHeight,
              width: _mapWidth,
              child: _googleMap,
            ),
          ),
        ),
      ),
    ];
    Widget _desposition;
    if (_maxWidth >= tabletWidth) {
      Column columnWrapper = Column(children: relatedProducts);
      _desposition = Row(children: allChildren + [columnWrapper]);
    } else {
      allChildren.addAll(relatedProducts);
      _desposition = Column(
        children: allChildren +
            <Widget>[
              if (textWidget != null) textWidget!,
            ],
      );
    }

    return Container(
        color: backgroundAppColor,
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: _desposition);
  }

  List<Widget> _getShopProducts() {
    Shop? shop = DatabaseManager.getShop(selectedMarker!.value);
    List<Widget> listOfProducts = [];
    int counter = 0;
    for (var productId in shop!.products) {
      counter++;
      listOfProducts.add(SizedBox(
          width: 300,
          height: _maxHeight * 0.4,
          child: ProductCard(
            productId: productId,
          )));
      if (counter == 5) {
        break;
      }
    }
    return listOfProducts;
  }

  void _redirectToShopPage() {
    SecondaryNavigator.push(context, NestedNavigatorRoutes.shop,
        routeArgs: {'shopId': selectedMarker!.value.toString()});
  }
}
