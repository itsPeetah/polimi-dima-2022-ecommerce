import 'package:dima/main.dart';
import 'package:dima/util/database/list_of_products.dart';
import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({
    Key? key,
  }) : super(key: key);
  @override
  State<FavoritesPage> createState() => FavoritesPageState();
}

class FavoritesPageState extends State<FavoritesPage> {
  List<Widget> listOfItems = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: ((context, appState, _) {
        return _buildShoppingBody();
      }),
    );
  }

  _getItemsInFavorites() {
    listOfItems = [];
    var listFavs = getItemsInFavorites();
    for (var fav in listFavs) {
      listOfItems.add(fav);
    }
  }

  Widget _buildShoppingBody() {
    _getItemsInFavorites();
    return Column(
      children: [
        const TextLarge(text: 'Your favorite products are:'),
        Expanded(
            child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: listOfItems))
      ],
    );
  }
}
