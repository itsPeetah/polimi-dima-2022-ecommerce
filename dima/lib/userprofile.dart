import 'package:flutter/material.dart';

import 'components/drawer.dart';
import 'components/questionbar.dart';

class UserProfileRoute extends StatelessWidget {
  const UserProfileRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideBarDrawer(),
        appBar: AppBar(
            toolbarHeight: 60,
            flexibleSpace: const SafeArea(
                child: QuestionBar(title: 'Search for something new!'))),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
                'Not yet implemented, go back to the previous page!'),
          ),
        ));
  }
}
