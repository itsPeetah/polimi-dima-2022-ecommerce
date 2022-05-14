import 'package:carousel_slider/carousel_slider.dart';
import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:dima/widgets/product/product_card.dart';
import 'package:flutter/material.dart';

class ProductCarousel extends StatefulWidget {
  const ProductCarousel({Key? key}) : super(key: key);

  @override
  State<ProductCarousel> createState() => ProductCarouselState();
}

class ProductCarouselState extends State<ProductCarousel> {
  int _currentIndex = 0;
  List productIds = [0, 1, 2, 3, 4];

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextLarge(text: "Top Items of the week:"),
        CarouselSlider(
          items: _buildProductCardList(context),
          options: CarouselOptions(
            height: 260.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            aspectRatio: 5.0,
            onPageChanged: (index, _) => _onPageChange(index),
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildDotterIndicator())
      ],
    );
  }

  List<Widget> _buildProductCardList(BuildContext context) {
    return productIds.map((product) {
      return Builder(builder: (BuildContext context) {
        return _buildProductCard(context, product);
      });
    }).toList();
  }

  Widget _buildProductCard(BuildContext context, int productId) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: Colors.grey[100],
        shadowColor: Colors.grey[900],
        child: ProductCard(
          productId: productId,
        ),
      ),
    );
  }

  List<Widget> _buildDotterIndicator() {
    return _map<Widget>(productIds, (index, url) {
      return Container(
        width: 10.0,
        height: 10.0,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == index
              ? Theme.of(context).primaryColor
              : Colors.grey,
        ),
      );
    });
  }
}
