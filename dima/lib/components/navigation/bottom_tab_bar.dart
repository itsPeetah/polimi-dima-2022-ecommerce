import 'package:flutter/material.dart';
import 'package:dima/util/navigation/tab_item.dart';

class BottomTabBar extends StatelessWidget {
  const BottomTabBar(
      {Key? key, required this.currentTab, required this.onSelectTab})
      : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    final selectedItemColor = Theme.of(context).primaryColor;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.home, selectedItemColor),
        _buildItem(TabItem.map, selectedItemColor),
        _buildItem(TabItem.cart, selectedItemColor),
        _buildItem(TabItem.profile, selectedItemColor),
      ],
      onTap: (index) => onSelectTab(TabItem.values[index]),
      currentIndex: currentTab.index,
      selectedItemColor: selectedItemColor,
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem, Color selectedItemColor) {
    return BottomNavigationBarItem(
      icon: Icon(
        tabIcon[tabItem],
        color: currentTab == tabItem ? selectedItemColor : Colors.grey,
      ),
      label: tabName[tabItem],
    );
  }
}
