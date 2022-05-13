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
  List productList = [null, null, null, null];

  List<T> _map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextLarge(text: "Top Items:"),
        CarouselSlider(
          options: CarouselOptions(
            height: 260.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            aspectRatio: 5.0,
            onPageChanged: (index, _) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: productList.map((product) {
            return Builder(builder: (BuildContext context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.grey[100],
                  shadowColor: Colors.grey[900],
                  child: ProductCard(),
                ),
              );
            });
          }).toList(),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _map<Widget>(productList, (index, url) {
              return Container(
                width: 10.0,
                height: 10.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
              );
            }))
      ],
    );
  }
}
