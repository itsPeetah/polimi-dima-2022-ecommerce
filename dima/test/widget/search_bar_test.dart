import 'package:dima/pages/authentication/signin.dart';
import 'package:dima/pages/search_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check that the search bar is visible',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ProductSearchPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(TextField, skipOffstage: false), findsOneWidget);
  });

  testWidgets(
      'Check that the search bar is interactable and the input persists',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ProductSearchPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(TextField, skipOffstage: false), findsOneWidget);

    String input = "Test input";

    for (final element
        in find.byType(TextField, skipOffstage: false).evaluate()) {
      TextField widget = element.widget as TextField;
      // widget.controller!.text = 'asasasasa';
      await tester.enterText(find.byWidget(widget), input);
      // await tester.tapAt(tester.getCenter(find.byWidget(element.widget)));
    }
    for (final element
        in find.byType(TextField, skipOffstage: false).evaluate()) {
      TextField widget = element.widget as TextField;
      // widget.controller!.text = 'asasasasa';
      assert(widget.controller != null);
      assert(widget.controller!.text == input);
      // await tester.tapAt(tester.getCenter(find.byWidget(element.widget)));
    }
  });
}
