import 'package:dima/pages/authentication/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check that the SignIn page is correctly instantiated',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
          home: Center(
        child: SignInPage(),
      )),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Sign In', skipOffstage: false), findsOneWidget);
    expect(find.textContaining('Email', skipOffstage: false), findsOneWidget);
    expect(
        find.textContaining('Password', skipOffstage: false), findsOneWidget);
    expect(find.textContaining('Cancel', skipOffstage: false), findsOneWidget);
  });
}
