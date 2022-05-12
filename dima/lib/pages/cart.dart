import 'package:dima/pages/misc/fork.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ForkPage(
      route1: "/profile",
      route2: "/map",
      title: "Cart",
    );
  }
}
