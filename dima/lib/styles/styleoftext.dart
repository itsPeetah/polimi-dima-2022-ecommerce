import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  const Headline({Key? key, required this.text}) : super(key: key);
  final String text;
  final Color color = Colors.blue;
  final Color bgColor = const Color.fromRGBO(0, 0, 0, 0.1);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(backgroundColor: bgColor, color: color, fontSize: 28),
    );
  }
}
