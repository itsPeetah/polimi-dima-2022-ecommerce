import 'package:dima/default_scaffold.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Firebase initialization and avoiding race condition
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  late Future<FirebaseApp> _fbApp;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _fbApp = Firebase.initializeApp();
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
            FirebaseApp fbApp = snapshot.data as FirebaseApp;
            print('Created');
            //firebase: fbApp
            return DefaultScaffold();
          } else {
            /// TODO: create loading screen
            print('Loading');
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
