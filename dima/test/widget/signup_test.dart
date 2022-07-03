import 'package:dima/pages/authentication/register.dart';
import 'package:dima/pages/authentication/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check that the SignUp page is correctly instantiated',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
          home: Center(
        child: RegisterPage(),
      )),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Sign Up', skipOffstage: false), findsOneWidget);
    expect(
        find.textContaining('Full Name', skipOffstage: false), findsOneWidget);
    expect(find.textContaining('Email', skipOffstage: false), findsOneWidget);
    expect(
        find.textContaining('Password', skipOffstage: false), findsOneWidget);
    expect(find.textContaining('Cancel', skipOffstage: false), findsOneWidget);
  });
}
