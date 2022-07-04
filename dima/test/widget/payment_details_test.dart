// PaymentPage
import 'package:dima/main.dart';
import 'package:dima/pages/paymentdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Check that the Thank You page is correctly instantiated',
      (WidgetTester tester) async {
    const _location = 'Lorem Ipsum Location';
    const _phone = '283892389238923';
    const _name = 'THIS NAME';
    const _price = 'xzxczxcz';

    await tester.pumpWidget(
      // We need a ChangeNotifierProvider because otherwise we can not get the state of the page.

      ChangeNotifierProvider(
        create: (context) => ApplicationState(),
        builder: (context, _) => const MaterialApp(
          home: Scaffold(
            body: PaymentDetailsPage(
              name: _name,
              location: _location,
              phone: _phone,
              price: _price,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Credit Card', skipOffstage: false),
        findsOneWidget);
    expect(find.textContaining('CVV', skipOffstage: false), findsOneWidget);
    expect(find.textContaining('name', skipOffstage: false), findsOneWidget);
    expect(
        find.textContaining('Continue', skipOffstage: false), findsOneWidget);
    expect(find.textContaining('Go back', skipOffstage: false), findsOneWidget);
    expect(find.byType(TextButton, skipOffstage: false), findsNWidgets(2));
    expect(find.byType(TextFormField, skipOffstage: false), findsNWidgets(3));
    expect(find.byType(Form, skipOffstage: false), findsOneWidget);
  });
}
