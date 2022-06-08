import 'package:dima/pages/misc/fork.dart';
import 'package:dima/widgets/product/catalogue_list.dart';
import 'package:dima/widgets/product/product_carousel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ProductCarousel(),
        ProductCatalogueList(),
      ],
    );
  }
}
