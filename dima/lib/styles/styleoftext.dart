import 'package:flutter/material.dart';

// Tablet:
const double tabletWidth = 600;
// COLORS
const Color backgroundColor1 = Color.fromARGB(207, 58, 114, 147);
const Color backgroundItemColor1 = Color.fromARGB(103, 255, 187, 118);
const Color dividerColor = Color.fromARGB(131, 0, 178, 218);
const Color questionBarColor = Color.fromARGB(255, 46, 62, 70);
const Color borderColor = Color.fromARGB(255, 20, 23, 29);

// Text color
const Color backgroundAppColor = Color.fromARGB(103, 215, 121, 27);
const Color headerTextColor = Color.fromARGB(255, 0, 140, 255);
const Color questionBarTextColor = Color.fromARGB(226, 255, 255, 255);
const Color titleTextColor = Color.fromARGB(255, 0, 0, 0);

// Bottom Bar color
const Color bottomBarColor = Color.fromARGB(255, 255, 143, 0);

// FONT Properties
const double productTitleSize = 22;
const double productTitleSizeTablet = 22 + 13;
const double productPriceSize = 15.99;
const double headerSize = 28;

// Icon or size
const double buttonSize = 15;
const double smallButtonTextSize = 18;
const double bigButtonTextSize = 18;

// Error text in form
const double errorTextSize = 14;

// Gradients
const BoxDecoration gradientStyleDark = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.center,
    colors: <Color>[
      Color(0x99000000),
      Color(0x00000000),
    ],
    tileMode: TileMode.clamp,
  ),
);
const BoxDecoration gradientStyleWhite = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.center,
    colors: <Color>[
      Color.fromARGB(27, 255, 255, 255),
      Color.fromARGB(117, 255, 255, 255),
    ],
    tileMode: TileMode.clamp,
  ),
);

class Headline extends StatelessWidget {
  const Headline({Key? key, required this.text}) : super(key: key);
  final String text;
  final Color color = headerTextColor;
  final Color bgColor = const Color.fromARGB(0, 0, 0, 0);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          backgroundColor: bgColor, color: color, fontSize: headerSize),
    );
  }
}

class ProductTitleCard extends StatelessWidget {
  const ProductTitleCard({Key? key, required this.text}) : super(key: key);
  final String text;
  final Color color = titleTextColor;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: color,
          fontSize: productTitleSize,
          fontFamily: 'Merriweather',
          // Merriweather or Lato
        ),
        textAlign: TextAlign.center);
  }
}
