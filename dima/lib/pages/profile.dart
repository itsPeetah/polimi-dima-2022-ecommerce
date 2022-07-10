import 'package:dima/util/navigation/navigation_nested.dart';
import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:dima/main.dart';
import 'package:dima/util/authentication/authentication.dart';
import 'package:dima/util/navigation/navigation_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  void _goToSignIn() {
    MainNavigator.push("/signin");
  }

  void _goToSignUp() {
    MainNavigator.push("/register");
  }

  void _goToFavoriteList() {
    SecondaryNavigator.push(context, NestedNavigatorRoutes.favorites);
  }

  void _goToHistoryPurchase() {
    SecondaryNavigator.push(context, NestedNavigatorRoutes.history);
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
    String username = FirebaseAuth.instance.currentUser?.displayName ?? "user";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextLarge(text: "Welcome, $username"),
        TextButtonLarge(
          text: "Your favorites",
          onPressed: _goToFavoriteList,
        ),
        TextButtonLarge(
          text: "Purchase history",
          onPressed: _goToHistoryPurchase,
        ),
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
        TextButtonLarge(
          text: "Your favorites",
          onPressed: _goToFavoriteList,
        ),
        TextButtonLarge(
          text: "Purchase history",
          onPressed: _goToHistoryPurchase,
        ),
      ],
    );
  }
}
