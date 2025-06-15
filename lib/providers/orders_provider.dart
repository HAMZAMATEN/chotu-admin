import 'dart:convert';

import 'package:chotu_admin/model/all_orders_model.dart';
import 'package:chotu_admin/model/order_analytics_model.dart';
import 'package:chotu_admin/providers/api_services_provider.dart';
import 'package:chotu_admin/utils/api_consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../model/pagination_model.dart';
import '../model/shop_model.dart';
import '../utils/functions.dart';

class OrdersProvider extends ChangeNotifier {
  ApiServicesProvider apiServicesProvider =
      navigatorKey.currentContext!.read<ApiServicesProvider>();

  Map<int, List<StoreModel>?>? pageViseStoresMap = {};

  String? selectedStore;

  DateTime? _startDate;
  DateTime? _endDate;

  DateTime? get startDate => _startDate;

  DateTime? get endDate => _endDate;

  String get formattedStartDate =>
      _startDate != null ? DateFormat('yyyy-MM-dd').format(_startDate!) : '';

  String get formattedEndDate =>
      _endDate != null ? DateFormat('yyyy-MM-dd').format(_endDate!) : '';

  PaginationModel? storePagination;

  List<StoreModel>? allStoresList;

  OrdersAnalyticsModel? ordersAnalyticsModel;

  AllOrdersModel? allOrdersModel;

  int _currentPage = 1;

  int get currentPage => _currentPage;

  void setCurrentPage(int val) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _currentPage = val;

      notifyListeners();
    });
  }

  void setStartDate(DateTime date) {
    _startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    _endDate = date;
    notifyListeners();
  }

  void setSelectedStore(String? val) {
    if (val == null) return;

    selectedStore = val;
    notifyListeners();
    print("selected:::$selectedStore");
  }

  Future<void> getOrderAnalytics() async {
    try {
      await apiServicesProvider
          .getRequestResponse(APIConstants.getOrdersAnalytics)
          .then((response) {
        if (response.statusCode == 200) {
          print("FETCHED DASHBOARD ANALYTICS SUCCESS");
          var json = jsonDecode(response.body);
          ordersAnalyticsModel = OrdersAnalyticsModel.fromJson(json);
          notifyListeners();
        } else {
          var json = jsonDecode(response.body);

          print(
              "EXCEPTION WHILE GETTING ORDER ANALYTICS WITH BODY:::$json AND STATUS CODE::::${response.statusCode}");
        }
      });
    } catch (e) {
      print("EXCEPTION WHILE GETTING ORDER ANALYTICS:::$e");
    }
  }

  Future<void> getAllStores() async {
    int currentPage = 1;
    bool hasMorePages = true;
    List<StoreModel> allStoresTempList = [];

    try {
      while (hasMorePages) {
        http.Response response = await apiServicesProvider.getRequestResponse(
            '${APIConstants.getAllStores}?page=$currentPage');

        print(
            "RESPONSE CODE FOR getAllStores Page $currentPage: ${response.statusCode}");

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          storePagination =
              PaginationModel.fromJson(responseData['pagination']);

          // ✅ Use helper method to convert list of JSON to list of StoreModel
          List<StoreModel> tempStoresList =
              StoreModel.listFromJson(responseData['data']);

          allStoresTempList.addAll(tempStoresList);
          pageViseStoresMap?[storePagination!.currentPage] = tempStoresList;

          if (storePagination!.currentPage < storePagination!.lastPage) {
            currentPage++;
          } else {
            hasMorePages = false;
          }
        } else {
          hasMorePages = false;
        }
      }

      // ✅ Store final list of all stores
      allStoresList?.clear();

      allStoresList = allStoresTempList;

      allStoresList!.insert(
        0,
        StoreModel(
            name: "All Shops",
            id: 0,
            fImg: "",
            cImg: "",
            categoryId: 0,
            address: "",
            latitude: "",
            longitude: "",
            status: 200),
      );
      setSelectedStore("0");
      notifyListeners();
    } catch (e) {
      AppFunctions.showToastMessage(
          message: "Exception while getAllStores: $e");
    }
  }

  List<Order>? allOrdersList;
  List<Order>? filterOrdersList;

  var searchController = TextEditingController();

  Pagination? pagination;

  Future<void> getAllOrders({
    required String storeId,
    required String storeName,
    required String startDate,
    required String endDate,
    required int page,
  }) async {
    setCurrentPage(page);
    allOrdersList = null;
    filterOrdersList = null;
    searchController.clear();
    try {
      http.Response response = await apiServicesProvider.getRequestResponse(
          "${APIConstants.getAllOrders}?store_id=$storeId&store_name=$storeName&start_date=$startDate&end_date=$endDate&page=$page");



      print("RESPONSE CODE FOR getAllOrders ${response.statusCode}");
      if (response.statusCode == 200) {
        AllOrdersModel allOrdersModel =
            AllOrdersModel.fromJson(jsonDecode(response.body));
        List<Order> tempUsersList = [];

        List<dynamic> dataList = (jsonDecode(response.body))['data'];

        pagination = allOrdersModel.pagination;

        setCurrentPage(int.parse(pagination?.currentPage.toString() ?? "1"));

        dataList.forEach((shopData) {
          Order order = Order.fromJson(shopData);
          tempUsersList.add(order);
        });
        allOrdersList?.clear();

        allOrdersList = tempUsersList;
      }
      notifyListeners();
    } catch (e) {
      AppFunctions.showToastMessage(
          message: "Exception while getAllOrders: $e");
    }
  }

  int getTotalProductsPurchased(List<StoreElement> stores) {
    int total = 0;

    for (final storeItem in stores) {
      for (final productItem in storeItem.products) {
        total += productItem.quantity ?? 0;
      }
    }

    return total;
  }

  void resetFilters() {
    _startDate = null;
    _endDate = null;
    selectedStore = '';

    notifyListeners();

    getAllOrders(
        storeId: "", storeName: "", startDate: "", endDate: "", page: 1);
  }
}
