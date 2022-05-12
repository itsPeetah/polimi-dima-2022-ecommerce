import 'dart:html';

import 'package:dima/components/misc/textWidgets.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  // TODO Move this to its own class to avoid creating a new one each build
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();

  String? _emailValidator(String? str) {
    final bool emailValid = str != null &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(str);
    return emailValid ? "Please, enter a valid email addres" : null;
  }

  String? _passwordValidator(String? str) {
    return str != null && str.isNotEmpty
        ? "Please, enter a longer password"
        : null;
  }

  void _signIn() async {
    print("Signing in...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: _emailValidator,
                decoration: const InputDecoration(hintText: "email..."),
                controller: _emailInputController,
              ),
              TextFormField(
                validator: _passwordValidator,
                decoration: const InputDecoration(hintText: "password..."),
                controller: _passwordInputController,
                obscureText: true,
              ),
              TextButtonLarge(text: "Sign In", onPressed: _signIn),
              TextButtonLarge(
                text: "Cancel",
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
