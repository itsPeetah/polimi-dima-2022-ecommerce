import 'package:dima/components/misc/textWidgets.dart';
import 'package:dima/main.dart';
import 'package:dima/pages/fork.dart';
import 'package:dima/util/authentication/authentication.dart';
import 'package:dima/util/navigation/main_routes.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: ((context, appState, _) {
        if (appState.loginState == ApplicationLoginState.loggedIn) {
          return Text("You are logged in");
        } else {
          return _buildNotLoggedInBody();
        }
      }),
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
