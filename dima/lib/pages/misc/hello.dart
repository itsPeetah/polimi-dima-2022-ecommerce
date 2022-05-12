import 'package:flutter/material.dart';

class HelloPage extends StatelessWidget {
  const HelloPage({Key? key, this.title = "Hello World!"}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Text(title, style: TextStyle(fontSize: 32, color: Colors.grey[500])),
    );
  }
}
