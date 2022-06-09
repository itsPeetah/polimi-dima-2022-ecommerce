import 'package:dima/util/database/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../styles/styleoftext.dart';
import '../home/product_home.dart';

class ProductCatalogueList extends StatefulWidget {
  const ProductCatalogueList({Key? key}) : super(key: key);

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

  _getAllProducts() {
    List<String> keys = [];
    for (String key in DatabaseManager.allProducts.keys) {
      keys.add(key);
    }
    for (String key in keys.reversed) {
      allChoices.add(ProductItem(product: DatabaseManager.allProducts[key]));
      allChoices.add(
        const Divider(
          height: 10,
          thickness: 5,
        ),
      );
    }
  }

  Widget _buildBody(context) {
    _getAllProducts();
    return Container(
      color: backgroundAppColor,
      child: Column(
        // controller: ScrollController(),
        // scrollDirection: Axis.vertical,
        children: <Widget>[
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: const Padding(
                        padding: EdgeInsets.all(25),
                        child: Headline(
                          text: "Explore more",
                        ),
                      ),
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
