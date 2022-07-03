// PaymentPage
import 'package:dima/main.dart';
import 'package:dima/pages/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Check that the Thank You page is correctly instantiated',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      // We need a ChangeNotifierProvider because otherwise we can not get the state of the page.
      ChangeNotifierProvider(
        create: (context) => ApplicationState(),
        builder: (context, _) => const MaterialApp(
          home: Scaffold(
            body: PaymentPage(
              showPage: false,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Enter your name', skipOffstage: false),
        findsOneWidget);
    expect(
        find.textContaining('Enter your desired location', skipOffstage: false),
        findsOneWidget);
    expect(find.textContaining('Enter your phone number', skipOffstage: false),
        findsOneWidget);
    expect(
        find.textContaining('Continue', skipOffstage: false), findsOneWidget);
    expect(find.textContaining('Cancel', skipOffstage: false), findsOneWidget);
    expect(find.byType(TextButton, skipOffstage: false), findsNWidgets(2));
    expect(find.byType(TextFormField, skipOffstage: false), findsNWidgets(3));
    expect(find.byType(Form, skipOffstage: false), findsOneWidget);
  });
}
