// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';

import '../../styles/styleoftext.dart';
import 'welcome_header.dart';

class HomePage extends StatelessWidget {
  const HomePage(
      {Key? key,
      required this.top15Choices,
      required this.preferredProducts,
      required this.width,
      required this.height})
      : super(key: key);

  final List<Widget> top15Choices;

  final double height;

  final List<Widget> preferredProducts;

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height * 0.88,
        child: Container(
            color: backgroundAppColor,
            child: ListView(
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const WelcomeHeader(),
                        const Headline(text: "Our choices for you"),
                        Container(
                          color: backgroundColor1,
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: Row(children: [
                            SizedBox(
                                height: height / 3,
                                width: width,
                                child: ListView(
                                    padding:
                                        EdgeInsets.only(left: width * 0.01),
                                    scrollDirection: Axis.horizontal,
                                    children: preferredProducts)),
                          ]),
                        ),
                        const Padding(
                            padding: EdgeInsets.all(25),
                            child: Headline(
                              text: "Top Choices of the Week",
                            )),
                        Container(
                          color: backgroundColor1,
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: Column(children: top15Choices),
                        ),
                      ],
                    ),
                  ),
                ])));
  }
}
