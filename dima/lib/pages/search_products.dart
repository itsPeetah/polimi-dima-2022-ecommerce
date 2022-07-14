import 'package:dima/model/product.dart';
import 'package:dima/util/database/database.dart';
import 'package:dima/util/navigation/navigation_nested.dart';
import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:flutter/material.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({Key? key}) : super(key: key);

  @override
  State<ProductSearchPage> createState() => ProductSearchPageState();
}

class ProductSearchPageState extends State<ProductSearchPage> {
  final TextEditingController _searchInputController = TextEditingController();
  List<Product> _listedItems = [];

  void _queryProducts(String query) {
    if (query.isNotEmpty) {
      final List<Product> queryResults = [];
      for (Product p in DatabaseManager.allProducts.values) {
        if (p.name.toLowerCase().contains(query)) {
          queryResults.add(p);
        }
      }
      setState(() {
        _listedItems = queryResults;
      });
    } else {
      setState(() {
        _listedItems = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              style: TextStyle(fontSize: 24),
              onChanged: (v) => _queryProducts(v.toLowerCase()),
              controller: _searchInputController,
            ),
          ),
          Expanded(
            child: ListView(
              children: _buildListedItemWidgets(context),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildListedItemWidgets(BuildContext context) {
    if (_searchInputController.value.text.isNotEmpty && _listedItems.isEmpty) {
      return [
        const TextLarge(text: "Oops, such product is not in our catalog :(")
      ];
    }

    final List<Widget> items = [];
    void addWidgetsToList(Product product) {
      items.add(Divider(
        height: 10,
        thickness: items.isNotEmpty ? 1 : 0,
      ));
      items.add(_buildListedItem(product, context));
    }

    _listedItems.forEach(addWidgetsToList);
    return items;
  }

  Widget _buildListedItem(Product p, BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () {
        SecondaryNavigator.push(context, "/product", routeArgs: {"id": p.id});
      },
      child: Row(
        children: [
          Image(
            fit: BoxFit.cover,
            image: p.image.image,
            height: 100,
            width: 100,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              p.name,
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          )
        ],
      ),
    );
  }
}
