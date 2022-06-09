import 'package:flutter/material.dart';

// COLORS
const Color backgroundColor1 = Color.fromARGB(207, 58, 114, 147);
const Color backgroundItemColor1 = Color.fromARGB(76, 72, 148, 162);
const Color dividerColor = Color.fromARGB(131, 69, 0, 28);
const Color questionBarColor = Color.fromARGB(255, 46, 62, 70);
const Color borderColor = Color.fromARGB(255, 20, 23, 29);

// Text color
const Color backgroundAppColor = Color.fromARGB(103, 221, 198, 124);
const Color headerTextColor = Colors.blue;
const Color questionBarTextColor = Color.fromARGB(226, 255, 255, 255);

// Bottom Bar color
const Color bottomBarColor = Color.fromARGB(255, 255, 143, 0);

// FONT Properties
const double productTitleSize = 24;
const double productPriceSize = 15.99;

// Icon or size
const double buttonSize = 15;
const double smallButtonTextSize = 18;
const double bigButtonTextSize = 18;

// Error text in form
const double errorTextSize = 14;

class Headline extends StatelessWidget {
  const Headline({Key? key, required this.text}) : super(key: key);
  final String text;
  final Color color = headerTextColor;
  final Color bgColor = const Color.fromARGB(0, 0, 0, 0);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(backgroundColor: bgColor, color: color, fontSize: 28),
    );
  }
}
