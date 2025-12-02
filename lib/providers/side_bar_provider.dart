import 'package:chotu_admin/screens/additional_settings/additional_settings_tab_screen.dart';
import 'package:chotu_admin/screens/all_product_images/all_product_images.dart';
import 'package:chotu_admin/screens/dashboard/dashboard_screen.dart';
import 'package:chotu_admin/screens/riders/all_riders_screen.dart';
import 'package:chotu_admin/screens/users/all_users.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/categories/categories.dart';
import '../screens/orders/orders.dart';
import '../screens/shops/shops_screen.dart';

class SideBarProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  final List<Widget> _screenStack = [
    const DashboardScreen(),
  ]; // Stack to manage screens

  Widget get currentScreen => _screenStack.last; // Always show top of stack

  List<Map<String, dynamic>> sideBarItems = [
    {"name": "Dashboard", "icon": FontAwesomeIcons.home},
    {"name": "Shops", "icon": FontAwesomeIcons.shop},
    {"name": "Orders", "icon": Icons.reorder},
    {"name": "All Users", "icon": FontAwesomeIcons.users},
    {"name": "All Riders", "icon": Icons.delivery_dining_outlined},
    {"name": "Categories", "icon": Icons.category},
    {"name": "Additional Settings", "icon": FontAwesomeIcons.gear},
    {"name": "Product Images", "icon": FontAwesomeIcons.images},
  ];

  /// Set new screen & push to stack
  void setScreen(Widget screen) {
    _screenStack.add(screen);
    notifyListeners();
  }

  /// Go back to the previous screen
  void goBack() {
    if (_screenStack.length > 1) {
      _screenStack.removeLast();
      notifyListeners();
    }
  }

  /// Set sidebar index & update screen
  void setIndex(int index) {
    _selectedIndex = index;
    _setScreenForIndex(index);
    notifyListeners();
  }

  void _setScreenForIndex(int index) {
    switch (index) {
      case 0:
        setScreen(const DashboardScreen());
        // setScreen(ShiftDetailScreen());
        break;
      case 1:
        setScreen( ShopsScreen());
        break;
      case 2:
        setScreen(OrderDashboard());
        // setScreen(OrderDetailsScreen());
        break;
      case 3:
        setScreen(const AllUsersScreen());
        break;
      case 4:
        setScreen(const AllRidersScreen());
        break;
      case 5:
        setScreen(const CategoriesScreen());
        break;

      case 6:
        setScreen(const AddSettingsTabScreen());
        break;
      case 7:
        setScreen(const AllProductImagesScreen());
        break;
      default:
        setScreen(DashboardScreen());
    }
  }
}
