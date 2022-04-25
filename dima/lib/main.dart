import 'package:dima/components/home/homepage.dart';
import 'package:dima/components/map/map_component.dart';
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
      home: const MyHomePage(title: 'Search on AppName.com'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title = 'Search on AppName.com'})
      : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // resultColumn = SizedBox(
  // height: height / 3,
  // child: ListView(
  //   children: resultOfQuery,
  // ));
  // if (queryAsked) resultColumn
  final preferredProducts = <Widget>[];
  final top15Choices = <Widget>[];
  bool queryAsked = false;
  List<Widget> resultOfQuery = <Widget>[];
  TextEditingController questionBarTextController = TextEditingController();
  void _incrementCounter() {
    setState(() {});
  }

  int _selectedIndex = 0;
  _tappedOutside() {
    setState(() {
      if (resultOfQuery.isNotEmpty) {
        queryAsked = false;
        resultOfQuery = <Widget>[];
      }
      questionBarTextController.clear();
    });
    FocusManager.instance.primaryFocus?.unfocus();
  }

  searchDB(String x) {
    var resultQuery = <Widget>[];
    query(x).forEach((preference) => {
          if (resultQuery.length < 8)
            {
              resultQuery.add(Padding(
                  padding:
                      const EdgeInsets.only(left: 400 / 20, right: 800 / 20),
                  child: ProductItemHorizontal(product: preference)))
            }
        });
    return showProducts(resultQuery, x);
  }

  showProducts(List<Widget> resultQuery, String x) {
    setState(() {
      if (resultQuery.isNotEmpty && x.isNotEmpty) {
        queryAsked = true;
        resultOfQuery = resultQuery;
      } else {
        queryAsked = false;
        resultOfQuery = <Widget>[];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    var iconHeight = height * 0.033;
    Widget questionBar = Padding(
        padding: EdgeInsets.only(left: width * 0.11),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(width * 0.02),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.3),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                    color: const Color.fromARGB(255, 175, 208, 212))),
            child: Row(children: [
              Icon(Icons.search, size: (iconHeight)),
              SizedBox(
                width: width * 0.7,
                child: TextField(
                  controller: questionBarTextController,
                  decoration: InputDecoration.collapsed(hintText: widget.title),
                  onChanged: (x) => searchDB(x),
                ),
              ),
            ]),
          ),
        ));

    if (preferredProducts.isEmpty) {
      userPref().forEach((preference) => preferredProducts.add(Padding(
          padding: EdgeInsets.only(right: width * 0.05),
          child: ProductItem(product: preference))));
    }
    if (top15Choices.isEmpty) {
      getAllDb().forEach((preference) => {
            if (top15Choices.length < 15)
              {
                top15Choices.add(Padding(
                    padding:
                        EdgeInsets.only(left: width / 20, right: width / 20),
                    child: ProductItemHorizontal(product: preference)))
              },
            if (top15Choices.length < 15 - 1)
              {
                top15Choices.add(
                  Divider(
                    color: dividerColor,
                    thickness: 3,
                    indent: width / 20,
                    endIndent: width / 20,
                  ),
                )
              }
          });
    }
    List<Widget> _widgetOptions = <Widget>[
      HomePage(
          top15Choices: top15Choices,
          preferredProducts: preferredProducts,
          width: width,
          height: height),
      const MapContainer(),
      const UserProfileRoute(titleQuestion: 'Search for something new!'),
      const ShoppingCartRoute(
          titleQuestion: 'Do you want to buy something else?'),
    ];
    var body = queryAsked
        ? GestureDetector(
            child: Stack(children: [
              _widgetOptions.elementAt(_selectedIndex),
              ListView(children: resultOfQuery),
            ]),
            onTap: () => _tappedOutside())
        : Stack(children: [_widgetOptions.elementAt(_selectedIndex)]);
    return Scaffold(
      appBar: AppBar(
          // toolbarHeight: 60,
          flexibleSpace: SafeArea(child: questionBar)),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      drawer: const SideBarDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shopping Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: bottomBarColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
