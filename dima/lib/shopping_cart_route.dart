import 'package:flutter/material.dart';

class ShoppingCartRoute extends StatelessWidget {
  const ShoppingCartRoute(
      {Key? key, this.titleQuestion = 'Do you want to buy something else?'})
      : super(key: key);
  final String titleQuestion;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Not yet implemented, go back to the previous page!'),
      ),
    );
  }
}
