import 'package:dima/main.dart';
import 'package:dima/pages/authentication/register.dart';
import 'package:dima/pages/authentication/signin.dart';
import 'package:dima/pages/search_products.dart';
import 'package:dima/util/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Check that the Search page works correctly',
      (WidgetTester tester) async {
    DatabaseManager.updateProductTester();
    // await tester.pumpWidget(
    //   MaterialApp(home: Center(child: ProductSearchPage())),
    // );
    MyApp _myApp = const MyApp();
    await tester.runAsync(() async {
      await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => ApplicationState(initializer: () {
          return;
        }),
        builder: (context, _) => _myApp,
      ));
    });
    // await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.search_rounded));
    await tester.pump(Duration(seconds: 1));

    for (final element
        in find.byType(TextField, skipOffstage: false).evaluate()) {
      TextField widget = element.widget as TextField;
      // widget.controller!.text = 'asasasasa';
      await tester.enterText(find.byWidget(widget), "asasas");
      // await tester.tapAt(tester.getCenter(find.byWidget(element.widget)));
    }
    await tester.pump(Duration(seconds: 1));
    expect(find.textContaining("Oops", skipOffstage: false), findsOneWidget);
  });
}
