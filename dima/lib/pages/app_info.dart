import 'package:dima/util/navigation/navigation_nested.dart';
import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:flutter/material.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextLarge(text: "App developed by"),
        TextLarge(text: "Etion Pinari"),
        TextLarge(text: "Pietro Moroni"),
        TextButtonLarge(
            text: "back",
            onPressed: () {
              SecondaryNavigator.pop(context);
            })
      ],
    );
  }
}
