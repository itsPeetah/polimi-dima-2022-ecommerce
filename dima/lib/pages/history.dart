import 'package:dima/main.dart';
import 'package:dima/styles/styleoftext.dart';
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
        return LayoutBuilder(builder: (context, BoxConstraints constraints) {
          return _buildShoppingBody(constraints);
        });
      }),
    );
  }

  _getItemsInBought(bool wantDividers) {
    listOfItems = [];
    List<Widget> listHistory;
    if (wantDividers) {
      listHistory = getItemsInBought(dividers: wantDividers);
    } else {
      listHistory = getOnlyItemsInBought();
    }
    for (var history in listHistory) {
      listOfItems.add(history);
    }
  }

  Widget _buildShoppingBody(BoxConstraints constraints) {
    bool wantDividers = constraints.maxWidth < tabletWidth;
    _getItemsInBought(wantDividers);
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
        const TextLarge(text: 'Last purchased:'),
        Expanded(child: _viewMode)
      ],
    );
  }
}
