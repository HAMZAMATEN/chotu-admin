import 'dart:convert';

import 'package:chotu_admin/main.dart';
import 'package:chotu_admin/model/category_model.dart';
import 'package:chotu_admin/model/shop_model.dart';
import 'package:chotu_admin/providers/api_services_provider.dart';
import 'package:chotu_admin/utils/api_consts.dart';
import 'package:chotu_admin/utils/functions.dart';
import 'package:chotu_admin/utils/toast_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class StoreProvider extends ChangeNotifier {
  ApiServicesProvider apiServicesProvider = navigatorKey.currentContext!.read<ApiServicesProvider>();

  List<StoreModel>? allStoresList;
  int activeStoresLength = 0;
  int inActiveStoresLength = 0;

  List<CategoryModel>? allCategoriesList;


  Future<void> getAllStores() async{
    try{
      http.Response response = await apiServicesProvider.getRequestResponse(APIConstants.getAllStores);

      print("RESPONSE CODE FOR getAllStores ${response.statusCode}");
      if(response.statusCode == 200){
        List<StoreModel> tempSotresList = [];
        List<dynamic> dataList = (jsonDecode(response.body))['data'];
        dataList.forEach((shopData){
          StoreModel store = StoreModel.fromJson(shopData);
          tempSotresList.add(store);
        });
        allStoresList?.clear();
        allStoresList = tempSotresList;
      }
      notifyListeners();
    }catch(e){
      AppFunctions.showToastMessage(message: "Exception while getAllStores: $e");
    }
  }

  Future<void> getAllCategories() async{
    try{
      http.Response response = await apiServicesProvider.getRequestResponse(APIConstants.getAllCategories);
      print("RESPONSE CODE FOR getAllCategories ${response.statusCode}");
      if(response.statusCode == 200){
        List<CategoryModel> tempCategoryList = [];
        List<dynamic> dataList = (jsonDecode(response.body))['data'];
        dataList.forEach((cat){
          CategoryModel categoryModel = CategoryModel.fromJson(cat);
          tempCategoryList.add(categoryModel);
        });
        allCategoriesList?.clear();
        allCategoriesList = tempCategoryList;
      }
      notifyListeners();
    }catch(e){
      AppFunctions.showToastMessage(message: "Exception while getAllCategories: $e");
    }
  }



  Future<void> updateStoreStatus(StoreModel storeModel) async{
    try{
      http.Response response = await apiServicesProvider.getRequestResponse(APIConstants.updateStoreStatus+'${storeModel.id}');
      print("RESPONSE CODE FOR updateStoreStatus ${response.statusCode}");
      if(response.statusCode == 200){
        StoreModel tempModel = storeModel;
        int currentStatus = tempModel.status;

        if(currentStatus == 0){
          tempModel.status = 1;
        }else if(currentStatus == 1){
          tempModel.status = 0;
        }

        // Find index of the store in allStoresList
        int index = allStoresList!.indexWhere((store) => store.id == storeModel.id);

        if (index != -1) {
          allStoresList![index] = tempModel; // Update the store in the list
        }
        AppFunctions.showToastMessage(message: "Store Status Updated Successfully");
      }
      ShowToastDialog.closeLoader();
      notifyListeners();
    }catch(e){
      AppFunctions.showToastMessage(message: "Exception while updateStoreStatus: $e");
      ShowToastDialog.closeLoader();
    }
  }


}