import 'package:flutter/material.dart';

class UserProfileRoute extends StatelessWidget {
  const UserProfileRoute(
      {Key? key, this.titleQuestion = 'Search for something new!'})
      : super(key: key);
  final String titleQuestion;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          true;
          //Navigator.pop(context);
        },
        child: const Text('Not yet implemented, go back to the previous page!'),
      ),
    );
  }
}
