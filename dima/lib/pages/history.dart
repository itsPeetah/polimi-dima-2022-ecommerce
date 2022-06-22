import 'package:dima/main.dart';
import 'package:dima/util/database/list_of_products.dart';
import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    Key? key,
  }) : super(key: key);
  @override
  State<HistoryPage> createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  List<Widget> listOfItems = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: ((context, appState, _) {
        return _buildShoppingBody();
      }),
    );
  }

  _getItemsInBought() {
    var listFavs = getItemsInBought();
    for (var fav in listFavs) {
      listOfItems.add(fav);
    }
  }

  Widget _buildShoppingBody() {
    _getItemsInBought();
    return Column(
      children: [
        const TextLarge(text: 'Last purchased:'),
        Expanded(
            child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: listOfItems))
      ],
    );
  }
}
