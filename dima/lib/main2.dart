import 'package:dima/default_scaffold.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  // Firebase initialization and avoiding race condition
  WidgetsFlutterBinding.ensureInitialized();
  print('Ensured WidgetsFlutterBinding is initialized');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  late Future<FirebaseApp> _fbApp;
  late FirebaseApp fbApp;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _fbApp =
        Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    return MaterialApp(
      title: 'AppName.com',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Firebase might have not been initialized correctly' +
                snapshot.error.toString());
            return const Text('Error');
          } else if (snapshot.hasData) {
            fbApp = snapshot.data as FirebaseApp;
            print('Firebase has been initialized correctly');
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
              if (user == null) {
                print('User is currently signed out!');
              } else {
                print('User is signed in!');
              }
            });
            //firebase: fbApp
            return DefaultScaffold();
          } else {
            /// TODO: create loading screen
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
