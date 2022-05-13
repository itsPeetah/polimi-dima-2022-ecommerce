import 'package:dima/pages/misc/fork.dart';
import 'package:dima/pages/misc/hello.dart';
import 'package:dima/util/database/database.dart';
import 'package:dima/widgets/product/product_card.dart';
import 'package:dima/widgets/product/product_carousel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductCarousel();
  }
}
