import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:dima/util/authentication/authentication.dart';
import 'package:dima/util/navigation/navigation_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../styles/styleoftext.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // SignInPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();

  var _hasError = false;

  void onSuccess() async {
    MainNavigator.pop();
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

  void _signIn() async {
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    final String email = _emailInputController.text;
    final String password = _passwordInputController.text;

    void onFailure(FirebaseAuthException e) {
      setState(() {
        _hasError = true;
      });
    }

    await Authentication.signInWithEmailAndPassword(
      email,
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
                validator: _emailValidator,
                decoration: const InputDecoration(
                    hintText: "Email",
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
              _buildErrorLabel(),
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

  Widget _buildErrorLabel() {
    final style = _hasError
        ? TextStyle(color: Colors.red)
        : TextStyle(color: Colors.transparent);

    return Text(
      "Invalid credentials...",
      style: style,
    );
  }
}
