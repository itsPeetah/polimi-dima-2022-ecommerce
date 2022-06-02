import 'package:flutter/material.dart';
import 'package:dima/util/navigation/navigation_nested.dart';
import 'package:dima/util/navigation/tab_item.dart';
import 'package:dima/widgets/navigation/nested_navigator.dart';
import 'bottom_tab_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => MainNavigationState();
}

class MainNavigationState extends State<MainNavigation> {
  final _pageController = PageController(initialPage: 0);
  var _currentTab = TabItem.home;

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // Clicking the tab item again will bring back to "/"
      SecondaryNavigator.of(tabItem).popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _pageController.jumpToPage(tabItem.index);
        _setCurrentTab(tabItem);
      });
    }
  }

  void _setCurrentTab(TabItem tabItem) {
    _currentTab = tabItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(_currentTab),
      body: PageView(
        controller: _pageController,
        physics:
            const NeverScrollableScrollPhysics(), // avoid scrolling from page to page
        children: [
          _buildNestedNavigator(TabItem.home),
          _buildNestedNavigator(TabItem.map),
          _buildNestedNavigator(TabItem.cart),
          _buildNestedNavigator(TabItem.profile),
        ],
      ),
      bottomNavigationBar: BottomTabBar(
        currentTab: _currentTab,
        onSelectTab: _selectTab,
      ),
    );
  }

  Widget _buildNestedNavigator(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.home:
        return NestedNavigator(
          navigatorKey: SecondaryNavigator.homeNavigatorKey,
          initialRoute: NestedNavigatorRoutes.root,
          onGenerateRoute: NestedNavigatorRouter.generateHomeRoute,
        );
      case TabItem.map:
        return NestedNavigator(
          navigatorKey: SecondaryNavigator.mapNavigatorKey,
          initialRoute: NestedNavigatorRoutes.root,
          onGenerateRoute: NestedNavigatorRouter.generateMapRoute,
        );
      case TabItem.cart:
        return NestedNavigator(
          navigatorKey: SecondaryNavigator.cartNavigatorKey,
          initialRoute: NestedNavigatorRoutes.root,
          onGenerateRoute: NestedNavigatorRouter.generateCartRoute,
        );
      case TabItem.profile:
        return NestedNavigator(
          navigatorKey: SecondaryNavigator.profileNavigatorKey,
          initialRoute: NestedNavigatorRoutes.root,
          onGenerateRoute: NestedNavigatorRouter.generateProfileRoute,
        );
    }
  }

  AppBar _buildAppBar(TabItem tab) {
    switch (tab) {
      default:
        return AppBar(
          title: const Text("App bar not implemented"),
        );
    }
  }
}
