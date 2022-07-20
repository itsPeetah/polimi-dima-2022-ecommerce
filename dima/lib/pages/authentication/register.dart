import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:dima/util/authentication/authentication.dart';
import 'package:dima/util/navigation/navigation_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../styles/styleoftext.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameInputController = TextEditingController();
  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();

  String? _nameValidator(String? str) {
    return str == null || str.isEmpty ? "Please enter a longer name" : null;
  }

  String? _emailValidator(String? str) {
    final bool emailValid = str != null &&
        RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
            .hasMatch(str);
    return emailValid ? null : "Please enter a valid email addres";
  }

  String? _passwordValidator(String? str) {
    return str == null || str.isEmpty ? "Please enter a longer password" : null;
  }

  void _signUp() async {
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    final String name = _nameInputController.text;
    final String email = _emailInputController.text;
    final String password = _passwordInputController.text;

    void onSuccess() {
      MainNavigator.pop();
    }

    void onFailure(FirebaseAuthException e) {}

    await Authentication.registerAccount(
      email,
      name,
      password,
      onSuccess,
      onFailure,
    );
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
                validator: _nameValidator,
                decoration: const InputDecoration(
                    hintText: "Full Name",
                    errorStyle: TextStyle(fontSize: errorTextSize)),
                controller: _nameInputController,
              ),
              TextFormField(
                validator: _emailValidator,
                decoration: const InputDecoration(
                    hintText: "Email Address",
                    errorStyle: TextStyle(fontSize: errorTextSize)),
                controller: _emailInputController,
              ),
              TextFormField(
                validator: _passwordValidator,
                decoration: const InputDecoration(
                    hintText: "Password",
                    errorStyle: TextStyle(fontSize: errorTextSize)),
                controller: _passwordInputController,
                obscureText: true,
              ),
              TextButtonLarge(text: "Sign Up", onPressed: _signUp),
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
