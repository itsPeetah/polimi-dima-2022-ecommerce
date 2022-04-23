import 'package:flutter/material.dart';

// COLORS
const Color backgroundColor1 = Color.fromARGB(207, 58, 114, 147);
const Color backgroundItemColor1 = Color.fromARGB(76, 72, 148, 162);
const Color dividerColor = Color.fromARGB(131, 69, 0, 28);
const Color backgroundAppColor = Color.fromARGB(103, 221, 198, 124);

// FONT Properties
const double productTitleSize = 24;
const double productPriceSize = 15.99;

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
