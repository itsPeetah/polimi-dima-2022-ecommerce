import 'package:carousel_slider/carousel_slider.dart';
import 'package:dima/styles/styleoftext.dart';
import 'package:flutter/material.dart';

import 'package:dima/components/questionbar.dart';
import 'package:dima/components/product.dart';
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
      home: const MyHomePage(title: 'Search on AppName.com'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final preferredProducts = <Widget>[];
  final top15Choices = <Widget>[];
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    if (preferredProducts.isEmpty) {
      userPref().forEach((preference) => preferredProducts.add(Padding(
          padding: EdgeInsets.only(right: width * 0.05),
          child: ProductItem(product: preference))));
    }
    if (top15Choices.isEmpty) {
      getAllDb().forEach((preference) => {
            if (top15Choices.length < 15)
              top15Choices.add(Padding(
                  padding: EdgeInsets.only(right: width / 20),
                  child: ProductItem(product: preference)))
          });
    }

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60,
          flexibleSpace: SafeArea(child: QuestionBar(title: widget.title))),

      body: SizedBox(
          width: width,
          height: height * 0.9,
          child: ListView(children: [
            Center(
              child: Column(
                children: [
                  const Headline(text: "Our choices for you"),
                  Row(
                      // scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                            height: height / 3,
                            width: width,
                            child: ListView(
                                padding: EdgeInsets.only(left: width * 0.01),
                                scrollDirection: Axis.horizontal,
                                children: preferredProducts)),
                      ]),
                  const Padding(
                      padding: EdgeInsets.all(25),
                      child: Headline(
                        text: "Top Choices of the Week",
                      )),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            height: height / 3,
                            width: width,
                            child: ListView(
                                padding: EdgeInsets.only(left: width * 0.01),
                                scrollDirection: Axis.horizontal,
                                children: top15Choices))
                      ]),
                ],
              ),
            ),
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      drawer: const SideBarDrawer(),
    );
  }
}
