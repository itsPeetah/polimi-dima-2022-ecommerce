import 'package:dima/components/misc/textWidgets.dart';
import 'package:dima/main.dart';
import 'package:dima/util/authentication/authentication.dart';
import 'package:dima/util/navigation/main_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  void _goToSignIn() {
    // .then(...) is a janky solution to force the widget to rebuild.
    // The consumer is not notified when in the signin page so the screen
    // does not update to signed in after popping back.
    // Forcing the page to reload fixes this...
    MainNavigator.push("/signin").then((_) => setState(() {}));
  }

  void _goToSignUp() {
    MainNavigator.push("/register").then((_) => setState(() {}));
  }

  void _signOut() {
    Authentication.signOut();
    setState(() {});
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TextLarge(text: "You are logged in."),
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
