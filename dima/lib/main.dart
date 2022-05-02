import 'package:dima/components/home/homepage.dart';
import 'package:dima/components/map/map_component.dart';
import 'package:dima/components/question_bar_result.dart';
import 'package:dima/default_scaffold.dart';
import 'package:dima/shoppingcartroute.dart';
import 'package:dima/styles/styleoftext.dart';
import 'package:dima/userprofile.dart';
import 'package:flutter/material.dart';

import 'package:dima/components/home/product_home.dart';
import 'package:dima/components/home/product_home_horizontal.dart';
import 'package:dima/components/dbs.dart';
import 'package:dima/components/drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppName.com',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: DefaultScaffold(),
    );
  }
}
