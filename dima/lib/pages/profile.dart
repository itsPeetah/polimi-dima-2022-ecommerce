import 'package:dima/pages/fork.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ForkPage(
      route1: "/map",
      route2: "/cart",
      title: "Profile",
    );
  }
}
