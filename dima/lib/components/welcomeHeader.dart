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
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// TODO: Put the text on top of the image instead of it being in the bottom
        Padding(
            padding: EdgeInsets.all(width * 0.02),
            child: Image.asset('../../images/twoMenShakingHands.jpg')),
        const Text(
          'Welcome to AppName.com',
        ),
      ],
    );
  }
}
