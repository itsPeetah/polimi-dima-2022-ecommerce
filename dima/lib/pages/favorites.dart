import 'package:dima/main.dart';
import 'package:dima/util/database/list_of_products.dart';
import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../styles/styleoftext.dart';

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
        return LayoutBuilder(builder: (context, BoxConstraints constraints) {
          return _buildShoppingBody(constraints);
        });
      }),
    );
  }

  _getItemsInFavorites(bool wantDividers) {
    listOfItems = [];
    var listFavs = getItemsInFavorites(dividers: wantDividers);
    for (var fav in listFavs) {
      listOfItems.add(fav);
    }
  }

  Widget _buildShoppingBody(BoxConstraints constraints) {
    bool wantDividers = constraints.maxWidth < tabletWidth;
    _getItemsInFavorites(wantDividers);
    Widget _viewMode = ListView(children: listOfItems);
    if (!wantDividers) {
      _viewMode = GridView.count(
          childAspectRatio: 16 / 8,
          padding: const EdgeInsets.all(0),
          crossAxisCount: 2,
          mainAxisSpacing: 22,
          scrollDirection: Axis.vertical,
          children: listOfItems);
    }
    return Column(
      children: [
        const TextLarge(text: 'Your favorite products are:'),
        Expanded(child: _viewMode)
      ],
    );
  }
}
