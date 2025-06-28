import 'dart:convert';

import 'package:chotu_admin/main.dart';
import 'package:chotu_admin/model/pagination_model.dart';
import 'package:chotu_admin/model/product_model.dart';
import 'package:chotu_admin/model/shop_analytics_model.dart';
import 'package:chotu_admin/providers/api_services_provider.dart';
import 'package:chotu_admin/utils/api_consts.dart';
import 'package:chotu_admin/utils/app_constants.dart';
import 'package:chotu_admin/utils/functions.dart';
import 'package:chotu_admin/utils/toast_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class StoreProductProvider extends ChangeNotifier {
  ApiServicesProvider apiServicesProvider =
      navigatorKey.currentContext!.read<ApiServicesProvider>();

  /// Store Variables
  //< storeID <pageNo,List<ProductModel>>>
  Map<int, Map<int, List<ProductModel>>> storeProductsMap = {};
  PaginationModel? storeProductPagination;

  /// Store Analytics Variables in map against storeId
  Map<int, StoreAnalyticsModel> storeAnalyticsModelMap = {};

  /// products variables
  Map<String, dynamic>? productImageMap;
  int? productCategoryId;

  Future<void> getStoreProducts({required int storeId, int? page = 1}) async {
    try {
      /// get store analytics
      getStoreAnalytics(storeId: storeId);

      http.Response response = await apiServicesProvider.getRequestResponse(
          APIConstants.getProductByStoreId + '${storeId}' + '?page=${page}');

      print("RESPONSE CODE FOR getStoreProducts ${response.statusCode}");

      if (response.statusCode == 200) {
        storeProductPagination =
            PaginationModel.fromJson(jsonDecode(response.body)['pagination']);
        List<ProductModel> tempProdList = [];

        List<dynamic> dataList = (jsonDecode(response.body))['data'];

        dataList.forEach((prodData) {
          print(prodData);
          ProductModel product = ProductModel.fromJson(prodData);
          tempProdList.add(product);
        });
        if (storeProductsMap[storeId] == null) {
          storeProductsMap[storeId] = {};
        }

        storeProductsMap[storeId]![storeProductPagination!.currentPage] = tempProdList.toSet().toList();
        print(
            "LENGTH OF PRODUCT ${storeProductsMap[storeId]![storeProductPagination!.currentPage]!.length}");
      } else {
        print("No Products Found");
        print("Error while getting store products: ${response.statusCode}");
        if (storeProductsMap[storeId] == null) {
          storeProductsMap[storeId] = {1: []};
          storeProductPagination = PaginationModel(
              currentPage: 1, lastPage: 1, perPage: 12, total: 0);
        }
      }
      notifyListeners();
    } catch (e) {
      print("Exception while getting store products $e");
      if (storeProductsMap[storeId] == null) {
        storeProductsMap[storeId] = {1: []};
        storeProductPagination =
            PaginationModel(currentPage: 1, lastPage: 1, perPage: 12, total: 0);
      }
      notifyListeners();
    }
  }

  Future<void> getStoreAnalytics({required int storeId}) async {
    try {
      http.Response response = await apiServicesProvider
          .getRequestResponse(APIConstants.getStoreAnalytics + '${storeId}');

      print("RESPONSE CODE FOR getStoreAnalytics ${response.statusCode}");
      print("RESPONSE FOR getStoreAnalytics ${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        storeAnalyticsModelMap[storeId] =
            StoreAnalyticsModel.fromJson((jsonDecode(response.body)['data']));
      } else {
        storeAnalyticsModelMap[storeId] =
            StoreAnalyticsModel(total: 0, active: 0, nonActive: 0);
      }
      notifyListeners();
    } catch (e) {
      storeAnalyticsModelMap[storeId] =
          StoreAnalyticsModel(total: 0, active: 0, nonActive: 0);
      print("Exception while getting store analytics $e");
      notifyListeners();
    }
  }

  Future<void> pickProductImage(BuildContext context) async {
    Map<String, dynamic>? imageFileMap =
        await AppFunctions().pickImageOnWeb(context);
    if (imageFileMap != null) {
      productImageMap = imageFileMap;
      notifyListeners();
    }
  }

  updateProductCategoryId(int id) {
    productCategoryId = id;
  }

  Future<void> addProductToDataBase(
      Map<String, dynamic> body, BuildContext context) async {
    try {
      print("ADD Product BODY IS ");
      print(body);
      EasyLoading.showToast("Uploading image files");
      EasyLoading.show();
      final uri =
          Uri.parse(APIConstants.addProduct); // 🔁 Replace with your API
      final request = await http.MultipartRequest('POST', uri);

      // Add image file
      request.files.add(
        http.MultipartFile.fromBytes(
          'img',
          productImageMap!['image'],
          filename: productImageMap!['fileName'],
        ),
      );

      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Authorization'] = 'Bearer ${AppConstants.authToken}';
      // Add text fields
      request.fields['name'] = body['name'];
      request.fields['category_id'] = body['category_id'];
      request.fields['brand'] = body['brand'];
      request.fields['price'] = body['price'];
      request.fields['discount_price'] = body['discount_price'];
      request.fields['unit'] = body['unit'];
      request.fields['unit_value'] = body['unit_value'];
      request.fields['description'] = body['description'];
      request.fields['store_id'] = body['store_id'];

      // Send request
      final response = await request.send();

      if (response.statusCode == 201) {
        AppFunctions.showToastMessage(message: "Product Added Successfully");
        print('Product ADDED SUCCESSFULLY');
      } else {
        AppFunctions.showToastMessage(
            message: "Failed to add product. Please try again.");
        print('Product Addition failed: ${response.statusCode}');
        print(
            'Product Addition failed: ${await response.stream.bytesToString()}');
      }
      EasyLoading.dismiss();
      clearControllers();
      Navigator.pop(context);
      notifyListeners();
    } catch (e) {
      EasyLoading.dismiss();
      clearControllers();
      Navigator.pop(context);
      AppFunctions.showToastMessage(
          message: "Failed to add shop. Please try again.");
      print("EXCEPTION WHILE ADDING Product TO DB ${e}");
    }
  }

  clearControllers() {
    productImageMap = null;
    productCategoryId = null;
    notifyListeners();
  }

  Future<void> updateProductStatus({required ProductModel product}) async {
    try {
      http.Response response = await apiServicesProvider.getRequestResponse(
          APIConstants.updateProductStatus + '${product.id}');
      print("RESPONSE CODE FOR updateStoreStatus ${response.statusCode}");
      if (response.statusCode == 200) {
        ProductModel tempModel = product;
        int currentStatus = tempModel.status;

        if (currentStatus == 0) {
          tempModel.status = 1;
        } else if (currentStatus == 1) {
          tempModel.status = 0;
        }

        // Find index of the store in allStoresList
        int index = storeProductsMap[product.store.id]![
                storeProductPagination!.currentPage]!
            .indexWhere((product) => product.id == product.id);

        if (index != -1) {
          storeProductsMap[product.store.id]![storeProductPagination!
              .currentPage]![index] = tempModel; // Update the store in the list
        }
        AppFunctions.showToastMessage(
            message: "Product Status Updated Successfully");
      } else {
        AppFunctions.showToastMessage(
            message: "Failed to update product status. Please try again.");
        print("Error while updating product status: ${response.statusCode}");
      }
      ShowToastDialog.closeLoader();
      notifyListeners();
    } catch (e) {
      AppFunctions.showToastMessage(
          message: "Exception while updateStoreStatus: $e");
      ShowToastDialog.closeLoader();
    }
  }

  Future<void> deleteProduct({required ProductModel product}) async {
    try {
      http.Response response = await apiServicesProvider
          .getRequestResponse(APIConstants.deleteProduct + '${product.id}');
      print("RESPONSE CODE FOR deleteProduct ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Product Deleted Successfully");
        // Find index of the store in allStoresList
        int index = storeProductsMap[product.store.id]![
                storeProductPagination!.currentPage]!
            .indexWhere((prod) => prod.id == product.id);

        if (index != -1) {
          storeProductsMap[product.store.id]![
                  storeProductPagination!.currentPage]!
              .removeAt(index);
        }
        AppFunctions.showToastMessage(
            message: "Product Deleted Successfully");
      } else {
        AppFunctions.showToastMessage(
            message: "Failed to delete product . Please try again.");
        print("Error while deleting product : ${response.statusCode}");
      }
      ShowToastDialog.closeLoader();
      notifyListeners();
    } catch (e) {
      AppFunctions.showToastMessage(
          message: "Exception while deleteProduct: $e");
      ShowToastDialog.closeLoader();
    }
  }


  Future<void> updateProductInDataBase(
      Map<String, dynamic> body, BuildContext context) async {
    try {
      print("Update Product BODY IS ");
      print(body);
      EasyLoading.showToast("Uploading image files");
      EasyLoading.show();
      final uri =
      Uri.parse(APIConstants.updateProduct + '${body['id']}'); // 🔁 Replace with your API
      final request = await http.MultipartRequest('POST', uri);

      // Add image file if user picked a new one
      if(productImageMap != null){
        request.files.add(
          http.MultipartFile.fromBytes(
            'img',
            productImageMap!['image'],
            filename: productImageMap!['fileName'],
          ),
        );
      }
      // define request headers
      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Authorization'] = 'Bearer ${AppConstants.authToken}';

      // Add text fields
      request.fields['name'] = body['name'];
      request.fields['category_id'] = body['category_id'];
      request.fields['brand'] = body['brand'];
      request.fields['price'] = body['price'];
      request.fields['discount_price'] = body['discount_price'];
      request.fields['unit'] = body['unit'];
      request.fields['unit_value'] = body['unit_value'];
      request.fields['description'] = body['description'];
      request.fields['store_id'] = body['store_id'];

      // Send request
      final response = await request.send();

      if (response.statusCode == 200) {
        AppFunctions.showToastMessage(message: "Product Updated Successfully");
        print('Product Updated SUCCESSFULLY');
      } else {
        AppFunctions.showToastMessage(
            message: "Failed to Updated product. Please try again.");
        print('Product Updation failed: ${response.statusCode}');
        print(
            'Product Updation failed: ${await response.stream.bytesToString()}');
      }
      EasyLoading.dismiss();
      clearControllers();
      Navigator.pop(context);
      notifyListeners();
    } catch (e) {
      EasyLoading.dismiss();
      clearControllers();
      Navigator.pop(context);
      AppFunctions.showToastMessage(
          message: "Failed to update shop. Please try again.");
      print("EXCEPTION WHILE updating Product TO DB ${e}");
    }
  }


  List<ProductModel>? searchedProducts = null;
  Future<void> searchProductByName({required String searchText,required String storeId}) async{
    try {
      http.Response response = await apiServicesProvider
          .getRequestResponse(APIConstants.searchProduct + 'name=${searchText}&shopId=${storeId}');

      print("RESPONSE CODE FOR searchProductByName ${response.statusCode}");
      print("RESPONSE FOR searchProductByName ${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        List<ProductModel> tempProdList = [];
        List<dynamic> dataList = (jsonDecode(response.body))['data'];

        dataList.forEach((prodData) {
          ProductModel product = ProductModel.fromJson(prodData);
          tempProdList.add(product);
        });
        searchedProducts = tempProdList;
      } else {
        searchedProducts = [];
      }
      notifyListeners();
    } catch (e) {
      searchedProducts = [];
      print("Exception while getting store analytics $e");
      notifyListeners();
    }
  }


  clearSearchProductsList(){
    searchedProducts = null;
    notifyListeners();
  }



}
