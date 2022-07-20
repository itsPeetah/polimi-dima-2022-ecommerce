// ignore_for_file: file_names
import 'package:dima/util/database/database.dart';
import 'package:dima/widgets/product/catalogue_list.dart';
import 'package:flutter/widgets.dart';

import '../model/shop.dart';
import '../styles/styleoftext.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key, required this.shopId}) : super(key: key);
  final String shopId;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return _createBody(constraints);
    });
  }

  Widget _createBody(BoxConstraints constraints) {
    Shop? shop = DatabaseManager.getShop(shopId);
    return SizedBox(
        width: constraints.maxWidth * 0.9,
        height: constraints.maxHeight * 0.9,
        child: ListView(
          children: [
            Container(
                color: backgroundAppColor,
                padding: const EdgeInsets.only(top: 15),
                child: Center(
                    child: Headline(text: 'All products of ' + shop!.name))),
            ProductCatalogueList(
              onlySelectedProducts: true,
              listOfProducts: shop.products,
            )
          ],
        ));
  }
}
