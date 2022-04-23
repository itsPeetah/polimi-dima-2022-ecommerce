import 'package:dima/components/dbs.dart';
import 'package:flutter/material.dart';

import '../shoppingcartroute.dart';
import '../userprofile.dart';

class QuestionBar extends StatefulWidget {
  const QuestionBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<QuestionBar> createState() => _QuestionBarState();
}

class _QuestionBarState extends State<QuestionBar> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    var iconHeight = height * 0.038;
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
            padding: EdgeInsets.only(left: (width * 0.1), top: (height * 0.01)),
            child: Row(children: [
              Container(
                padding: EdgeInsets.all(size.width * 0.014),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: const Color.fromARGB(255, 175, 208, 212))),
                child: Row(children: [
                  Icon(Icons.search, size: (iconHeight)),
                  SizedBox(
                    width: width * 0.6,
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                          hintText: widget.title, border: InputBorder.none),
                      onChanged: (x) => searchDB(x),
                    ),
                  )
                ]),
              )
            ])),
        SizedBox(
          child: Flex(
            direction: Axis.horizontal,
            children: [
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserProfileRoute())),
                  child: Icon(
                    Icons.person_outline_sharp,
                    size: iconHeight,
                    color: Colors.white,
                  )),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShoppingCartRoute())),
                child: Icon(
                  Icons.shopping_cart,
                  size: iconHeight,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  searchDB(String x) {
    return query(x);
  }
}
