import 'package:dima/components/drawer.dart';
import 'package:flutter/material.dart';

import 'components/questionbar.dart';

class ShoppingCartRoute extends StatelessWidget {
  const ShoppingCartRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideBarDrawer(),
        appBar: AppBar(
            toolbarHeight: 60,
            flexibleSpace: const SafeArea(
                child:
                    QuestionBar(title: 'Do you want to buy anything else?'))),
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
