
import 'package:chotu_admin/screens/analytics_reporting/analytics_reporting_scren.dart';
import 'package:chotu_admin/screens/users/user_screen.dart';

import '../../category/category_screen.dart';
import '../../dashboard/dashboard_screen.dart';
import '../../notification/notification_screen.dart';
import '../../order/order_screen.dart';
import '../../product/product_screen.dart';
import '../../riders/rider_screen.dart';
import '../../shop_management/shop_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../sub_category/sub_category_screen.dart';

class MainScreenProvider extends ChangeNotifier{
  Widget selectedScreen = DashboardScreen();



  navigateToScreen(String screenName) {
    switch (screenName) {
      case 'Dashboard':
        selectedScreen = DashboardScreen();
        break;
      case'Shop':
        selectedScreen=ShopScreen();
      case'User':
        selectedScreen=UserManagementScreen();// Break statement needed here
      case 'Category':
        selectedScreen = CategoryScreen();
        break;
      case 'Product':
        selectedScreen = ProductScreen();

      // case 'SubCategory':
      //   selectedScreen = SubCategoryScreen();
        break;
      case 'Riders':
        selectedScreen = RiderScreen();
        break;
      case 'Order':
        selectedScreen = OrderScreen();
        break;
      case 'Communication':
      //  selectedScreen = ChatScreen();
        break;
      case 'Analytics':
        selectedScreen = AnalyticsScreen();
        break;

      // case 'VariantType':
      //   selectedScreen = VariantsTypeScreen();
      //   break;
      // case 'Variants':
      //   selectedScreen = VariantsScreen();
      //   break;
      case 'Notifications':
        selectedScreen = NotificationScreen();
        break;
      default:
        selectedScreen = DashboardScreen();
    }
    notifyListeners();
  }
  
  
}