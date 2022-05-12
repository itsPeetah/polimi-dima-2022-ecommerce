import 'package:dima/pages/misc/fork.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ForkPage(route1: "/home", route2: "/map", title: "Home");
  }
}
