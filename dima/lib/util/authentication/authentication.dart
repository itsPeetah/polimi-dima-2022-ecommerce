import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

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
      // TODO:: Show on screen the error
      errorCallback(e);
    }
  }

  static void signOut() {
    FirebaseAuth.instance.signOut();
  }

  static void _createUserEntryInDatabase() {
    FirebaseDatabase.instance
        .ref()
        .child('/user' +
            '/' +
            FirebaseAuth.instance.currentUser!.uid +
            '/numTransactions')
        .set(0);
  }
}
