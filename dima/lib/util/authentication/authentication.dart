import 'package:firebase_auth/firebase_auth.dart';

enum ApplicationLoginState {
  loggedOut,
  loggedIn,
}

class Authentication {
  static Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    void Function() successCallback,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      successCallback();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  static Future<void> registerAccount(
      String email,
      String displayName,
      String password,
      void Function() successCallback,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
      successCallback();
      _createUserEntryInDatabase();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  static void signOut() {
    FirebaseAuth.instance.signOut();
  }

  static void _createUserEntryInDatabase() {
    // TODO IMPLEMENT THIS URGENTLY
  }
}
