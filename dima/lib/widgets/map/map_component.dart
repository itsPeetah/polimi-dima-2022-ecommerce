import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapContainer extends StatefulWidget {
  const MapContainer({Key? key, required this.parentSetState})
      : super(key: key);
  final Function parentSetState;
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapContainer> {
  late GoogleMapController mapController;
  /*
    Creation of a map marker
  */
  Map<MarkerId, Marker> markers =
      <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS
  MarkerId? selectedMarker;
  // LatLng? markerPosition;

  void _onShopTapped(MarkerId markerId) {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      print('Tapped marker is not null');
      setState(() {
        final MarkerId? previousMarkerId = selectedMarker;
        if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
          print('previousMarkerId is not null');
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
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

  /*
    End of creation of a map marker
   */
  final LatLng _center = const LatLng(45.464664, 9.188540);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _add();
    _add(latOffset: 0.015, longOffset: -0.015, shopName: 'LV');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: Set.from(markers.values),
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
