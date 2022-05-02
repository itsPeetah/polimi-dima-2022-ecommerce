import 'package:dima/default_scaffold.dart';
import 'package:dima/userprofile.dart';
import 'package:flutter/material.dart';
import 'package:dima/main.dart';

class SideBarDrawer extends StatelessWidget {
  const SideBarDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
              onTap: () => Navigator.pop(context),
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Row(children: const [Text('Header'), Icon(Icons.menu)]),
              )),
          ListTile(
            leading: const Icon(Icons.house),
            title: const Text('Home Page'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DefaultScaffold()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_outline_sharp),
            title: const Text('Your profile'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserProfileRoute()));
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
