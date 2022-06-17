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
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.5), Colors.transparent])),
      child: Padding(
        padding: EdgeInsets.only(right: 8, top: 4, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TODO Fix icon spacing in the corners
            _buildSearchButton(),
            const Text(
              "DIMA-Shop",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontSize: 20,
              ),
            ),
            _buildInfoButton(),
          ],
        ),
      ),
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
        size: 30,
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
        size: 30,
      ),
    );
  }
}
