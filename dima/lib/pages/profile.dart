import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:dima/main.dart';
import 'package:dima/util/authentication/authentication.dart';
import 'package:dima/util/navigation/main_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  void _goToSignIn() {
    MainNavigator.push("/signin");
  }

  void _goToSignUp() {
    MainNavigator.push("/register");
  }

  void _signOut() {
    Authentication.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: ((context, appState, _) {
        if (appState.loginState == ApplicationLoginState.loggedIn) {
          return _buildLoggedInBody();
        } else {
          return _buildNotLoggedInBody();
        }
      }),
    );
  }

  Widget _buildLoggedInBody() {
    // String username = FirebaseAuth.instance.currentUser?.displayName ?? "user";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TextLarge(text: "Welcome"),
        TextButtonLarge(
          text: "Sign out",
          onPressed: _signOut,
        ),
      ],
    );
  }

  Widget _buildNotLoggedInBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TextLarge(text: "You are not signed in."),
        TextButtonLarge(
          onPressed: _goToSignIn,
          text: "Sign In",
        ),
        TextButtonLarge(
          onPressed: _goToSignUp,
          text: "Sign Up",
        ),
      ],
    );
  }
}
