import 'package:dima/util/database/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../styles/styleoftext.dart';
import '../home/product_home.dart';

class ProductCatalogueList extends StatefulWidget {
  const ProductCatalogueList(
      {Key? key,
      this.onlySelectedProducts = false,
      this.listOfProducts = const []})
      : super(key: key);
  final bool onlySelectedProducts;
  final List<String> listOfProducts;
  @override
  State<ProductCatalogueList> createState() => ProductCatalogueListState();
}

class ProductCatalogueListState extends State<ProductCatalogueList> {
  List<Widget> allChoices = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: ((context, appState, _) {
        return _buildBody(context);
      }),
    );
  }

  _getAllProducts(List<String> ids) {
    List<String> keys = [];
    if (ids.isEmpty) {
      for (String key in DatabaseManager.allProducts.keys) {
        keys.add(key);
      }
    } else {
      keys = ids;
    }
    for (String key in keys.reversed) {
      allChoices.add(Container(
        decoration: gradientStyleWhite,
        child: ProductItem(product: DatabaseManager.allProducts[key]),
      ));
      allChoices.add(
        const Divider(
          color: dividerColor,
          indent: 5,
          endIndent: 5,
          height: 10,
          thickness: 5,
        ),
      );
    }
  }

  Widget _buildBody(context) {
    _getAllProducts(widget.listOfProducts);
    Widget _headline = const Padding(
      padding: EdgeInsets.all(25),
      child: Headline(
        text: "Explore more",
      ),
    );
    if (widget.onlySelectedProducts) {
      _headline = const SizedBox.shrink();
    }
    return Container(
      color: backgroundAppColor,
      child: Column(
        children: <Widget>[
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: _headline,
                    ),
                  ],
                ),
              )
            ] +
            allChoices,
      ),
    );
  }
}
