import 'package:dima/model/shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  testWidgets('Check that the Map page page is correctly instantiated',
      (WidgetTester tester) async {
    const description = 'Lorem Ipsum';
    Shop shop = Shop(
      coords: const LatLng(45.0, 9.0),
      name: 'Shop name',
      products: ['0', '1'],
      description: description,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4,
                ),
              ),
              child: SizedBox(
                height: 100,
                width: 100,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: shop.coords,
                    zoom: 11.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(GoogleMap, skipOffstage: false), findsOneWidget);
  });
}
