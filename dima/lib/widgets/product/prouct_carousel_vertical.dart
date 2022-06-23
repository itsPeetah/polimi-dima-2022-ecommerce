import 'package:carousel_slider/carousel_slider.dart';
import 'package:dima/main.dart';
import 'package:dima/util/database/database.dart';
import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:dima/widgets/product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerticalProductCarousel extends StatefulWidget {
  const VerticalProductCarousel({Key? key}) : super(key: key);

  @override
  State<VerticalProductCarousel> createState() =>
      VerticalProductCarouselState();
}

class VerticalProductCarouselState extends State<VerticalProductCarousel> {
  int _currentIndex = 0;
  List productIds = ["0", "1", "2", "3", "4"];

  List<T> _map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  void _onPageChange(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(builder: (_, __, ___) {
      return CarouselSlider(
        items: _buildProductCardList(context),
        options: CarouselOptions(
          scrollDirection: Axis.vertical,
          aspectRatio: MediaQuery.of(context).size.aspectRatio,
          viewportFraction: 1,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 8),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          onPageChanged: (index, _) => _onPageChange(index),
        ),
      );
    });
  }

  List<Widget> _buildProductCardList(BuildContext context) {
    // TODO: Add pagination maybe?
    return DatabaseManager.allProducts.keys.map((product) {
      return Builder(builder: (BuildContext context) {
        return _buildProductCard(context, product);
      });
    }).toList();
  }

  Widget _buildProductCard(BuildContext context, String productId) {
    return ProductCard(
      productId: productId,
    );
  }
}
