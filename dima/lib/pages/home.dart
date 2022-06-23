import 'package:dima/pages/misc/fork.dart';
import 'package:dima/widgets/product/catalogue_list.dart';
import 'package:dima/widgets/product/product_carousel.dart';
import 'package:dima/widgets/product/prouct_carousel_vertical.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: VerticalProductCarousel(),
    );
  }
}
