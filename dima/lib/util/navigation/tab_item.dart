import 'package:flutter/material.dart';

enum TabItem { home, map, cart, profile }

const Map<TabItem, String> tabName = {
  TabItem.home: "Home",
  TabItem.map: "Map",
  TabItem.cart: "Cart",
  TabItem.profile: "Profile"
};

const Map<TabItem, IconData> tabIcon = {
  TabItem.home: Icons.home,
  TabItem.map: Icons.map_outlined,
  TabItem.cart: Icons.shopping_cart,
  TabItem.profile: Icons.person
};
