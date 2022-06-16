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
        _buildTopRow()
      ],
    );
  }

  Widget _buildTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // TODO Fix icon spacing in the corners
        _buildSearchButton(),
        const Text(
          "DIMA-Shop",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w100,
            fontSize: 30,
          ),
        ),
        _buildInfoButton(),
      ],
    );
  }

  Widget _buildSearchButton() {
    return IconButton(
      onPressed: () {
        print("searching");
      },
      icon: const Icon(
        Icons.search,
        color: Colors.white,
        size: 40,
      ),
    );
  }

  Widget _buildInfoButton() {
    return IconButton(
      onPressed: () {
        print("info");
      },
      icon: const Icon(
        Icons.info_outline,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}
