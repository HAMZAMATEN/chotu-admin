import 'dart:convert';

import 'package:chotu_admin/main.dart';
import 'package:chotu_admin/providers/api_services_provider.dart';
import 'package:chotu_admin/utils/api_consts.dart';
import 'package:chotu_admin/utils/functions.dart';
import 'package:chotu_admin/utils/toast_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../model/category_model.dart';

class CategoriesProvider with ChangeNotifier {
  ApiServicesProvider apiServicesProvider =
      navigatorKey.currentContext!.read<ApiServicesProvider>();

  // Method to update the status of a user
  void updateStatus(int index, String status) {
    _categories[index]['status'] = status;
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  final List<Map<String, dynamic>> _categories = [
    {"index": 1, "name": "Fruits", "status": 1},
    {"index": 2, "name": "Pen", "status": 0},
    {"index": 3, "name": "Vegetables", "status": 0},
    {"index": 4, "name": "Food", "status": 1},
  ];

  List<Map<String, dynamic>> get categories => _categories;

  // List of statuses
  final List<String> statuses = ['Blocked', 'Approved'];

  // Get background color based on status
  Color getStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.green.withOpacity(0.4);
      // case 'Disapprove':
      //   return Colors.orange.withOpacity(0.4);
      case 0:
        return Colors.red.withOpacity(0.4);
      default:
        return Colors.orange.withOpacity(0.4); // Default for 'Pending'
    }
  }

  // Get text color based on status
  Color getTextColor(int status) {
    return status == 0 ? Colors.white : Colors.black;
  }

  Color getStatusIndicatorColor(String status) {
    switch (status) {
      case "Approved":
        return Colors.green;
      // case 'Disapprove':
      //   return Colors.orange;
      case "Blocked":
        return Colors.red;
      default:
        return Colors.orange; // Default for 'Pending'
    }
  }

  Pagination? pagination;

  int _currentPage = 1;

  int get currentPage => _currentPage;

  void setCurrentPage(val) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _currentPage = val;

      notifyListeners();
    });
  }

  AllCategoriesModel? allCategoriesModel;

  List<CategoryModel>? allCategoriesList;
  List<CategoryModel>? filterCategoriesList;

  TextEditingController searchController = TextEditingController();

  Future<void> getAllCategories(int page) async {
    setCurrentPage(page);
    searchController.clear();
    try {
      http.Response response = await apiServicesProvider
          .getRequestResponse(APIConstants.getAllCategories);

      print("RESPONSE CODE FOR getAllCategories ${response.statusCode}");
      // if (response.statusCode == 200) {
      //   List<CategoryModel> tempCategoriesList = [];
      //   List<dynamic> dataList = (jsonDecode(response.body))['data'];
      //   dataList.forEach((shopData) {
      //     CategoryModel category = CategoryModel.fromJson(shopData);
      //     tempCategoriesList.add(category);
      //   });
      //   allCategoriesList?.clear();
      //   allCategoriesList = tempCategoriesList;
      // }
      // notifyListeners();
      //

      if (response.statusCode == 200) {
        AllCategoriesModel categoriesModel =
            AllCategoriesModel.fromJson(jsonDecode(response.body));
        List<CategoryModel> tempCategoriesList = [];

        List<dynamic> dataList = (jsonDecode(response.body))['data'];

        pagination = categoriesModel.pagination;

        setCurrentPage(pagination!.currentPage ?? 1);

        dataList.forEach((shopData) {
          CategoryModel category = CategoryModel.fromJson(shopData);
          tempCategoriesList.add(category);
        });
        allCategoriesList?.clear();

        allCategoriesList = tempCategoriesList;
        filterCategoriesList?.clear();

        filterCategoriesList = tempCategoriesList;
      }
      notifyListeners();
    } catch (e) {
      AppFunctions.showToastMessage(
          message: "Exception while getAllCategories: $e");
    }
  }

  Future<void> addCategory(String categoryName) async {
    try {
      ShowToastDialog.showLoader('Adding Category');

      final response = await apiServicesProvider.postRequestResponse(
        APIConstants.addCategory,
        body: {
          "name": categoryName,
        },
      );

      print("RESPONSE CODE FOR addCategory: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);

        getAllCategories(_currentPage);
        AppFunctions.showToastMessage(message: "Category added successfully");
        notifyListeners();
      } else {
        AppFunctions.showToastMessage(message: "Failed to add category");
      }

      ShowToastDialog.closeLoader();
    } catch (e) {
      AppFunctions.showToastMessage(
          message: "Exception while adding category: $e");
      ShowToastDialog.closeLoader();
    }
  }

  Future<void> updateCategoryStatus(CategoryModel category) async {
    try {
      http.Response response = await apiServicesProvider.getRequestResponse(
          APIConstants.updateCategoryStatus + '${category.id}');
      print("RESPONSE CODE FOR updateCategoryStatus ${response.statusCode}");
      if (response.statusCode == 200) {
        CategoryModel tempModel = category;
        int currentStatus = tempModel.status ?? 0;

        if (currentStatus == 0) {
          tempModel.status = 1;
        } else if (currentStatus == 1) {
          tempModel.status = 0;
        }

        // Find index of the store in allUsersList
        int index =
            allCategoriesList!.indexWhere((store) => store.id == category.id);

        if (index != -1) {
          allCategoriesList![index] = tempModel; // Update the store in the list
        }
        AppFunctions.showToastMessage(
            message: "Category Status Updated Successfully");
      }
      ShowToastDialog.closeLoader();
      notifyListeners();
    } catch (e) {
      AppFunctions.showToastMessage(
          message: "Exception while updateCategoryStatus: $e");
      ShowToastDialog.closeLoader();
    }
  }

  Future<void> deleteCategory(CategoryModel category) async {
    try {
      ShowToastDialog.showLoader('Deleting Category');

      final response = await apiServicesProvider
          .getRequestResponse('${APIConstants.deleteCategory}${category.id}');

      print("RESPONSE CODE FOR deleteCategory: ${response.statusCode}");

      if (response.statusCode == 200) {
        // Remove the category from the list
        allCategoriesList?.removeWhere((c) => c.id == category.id);

        AppFunctions.showToastMessage(message: "Category deleted successfully");
        notifyListeners();
      } else {
        AppFunctions.showToastMessage(message: "Failed to delete category");
      }

      ShowToastDialog.closeLoader();
    } catch (e) {
      AppFunctions.showToastMessage(
          message: "Exception while deleting category: $e");
      ShowToastDialog.closeLoader();
    }
  }

  bool searchLoading = false;

  void setSearchLoading(val) {
    searchLoading = val;
    notifyListeners();
  }

  Future<void> searchCategories(String val) async {
    final query = val.toLowerCase();

    if (query.isNotEmpty) {
      setSearchLoading(true);

      // Filter from the original list
      filterCategoriesList = allCategoriesList
          ?.where((e) => e.name?.toLowerCase().contains(query) ?? false)
          .toList();

      setSearchLoading(false);
      notifyListeners();
    } else {
      // Reset to full list if search is empty
      await getAllCategories(_currentPage);
    }
  }
}
