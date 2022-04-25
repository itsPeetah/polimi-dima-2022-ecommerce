import 'package:flutter/material.dart';
import 'package:dima/styles/styleoftext.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
            padding: EdgeInsets.all(width * 0.02),
            child: Image.asset(
              './images/twoMenShakingHands.jpg',
              color: const Color.fromARGB(210, 0, 0, 0),
              colorBlendMode: BlendMode.dstATop,
            )),
        const Text(
          'Welcome to AppName.com',
          style: TextStyle(
              fontFamily: 'Schyler',
              fontWeight: FontWeight.bold,
              color: headerTextColor,
              fontSize: productTitleSize),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
