
import 'package:chotu_admin/screens/shop_management/provider/shop_provider.dart';
import '../screens/category/provider/category_provider.dart';
import '../screens/dashboard/provider/dash_board_provider.dart';
import '../screens/main/provider/main_screen_provider.dart';
import '../screens/notification/provider/notification_provider.dart';
import '../screens/product/provider/product_provider.dart';
import '../screens/riders/provider/rider_provider.dart';
import '../screens/sub_category/provider/sub_category_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../core/data/data_provider.dart';
import '../screens/order/provider/order_provider.dart';
import '../screens/users/provider/user_provider.dart';


extension Providers on BuildContext {
  ShopProvider get shopProvider=>Provider.of<ShopProvider>(this,listen:false);
  DataProvider get dataProvider => Provider.of<DataProvider>(this, listen: false);
  MainScreenProvider get mainScreenProvider => Provider.of<MainScreenProvider>(this, listen: false);
ProductProvider get productProvider => Provider.of<ProductProvider>(this, listen: false);
  CategoryProvider get categoryProvider => Provider.of<CategoryProvider>(this, listen: false);
  SubCategoryProvider get subCategoryProvider => Provider.of<SubCategoryProvider>(this, listen: false);
  RiderProvider get riderProvider=>Provider.of<RiderProvider>(this,listen: false);
  DashBoardProvider get dashBoardProvider => Provider.of<DashBoardProvider>(this, listen: false);
  UserProvider get userProvider => Provider.of<UserProvider>(this, listen: false);
  OrderProvider get orderProvider => Provider.of<OrderProvider>(this, listen: false);
  //CommunicationProvider get communicationProvider => Provider.of<CommunicationProvider>(this, listen: false);
  NotificationProvider get notificationProvider => Provider.of<NotificationProvider>(this, listen: false);
}