import 'package:dima/pages/misc/fork.dart';
import 'package:dima/widgets/product/catalogue_list.dart';
import 'package:dima/widgets/product/product_carousel.dart';
import 'package:dima/widgets/product/prouct_carousel_vertical.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox.expand(
          child: VerticalProductCarousel(),
        ),
        _buildSearchButton()
      ],
    );
  }

  Widget _buildSearchButton() {
    return TextButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black.withOpacity(0)),
        shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0)),
        overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0)),
        padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
      ),
      onPressed: () {
        print("seatching");
      },
      icon: const Icon(
        Icons.search_rounded,
        color: Colors.white,
        size: 40,
      ),
      label: const Text(
        "Search...",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
