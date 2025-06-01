import 'dart:convert';

import 'package:chotu_admin/main.dart';
import 'package:chotu_admin/model/pagination_model.dart';
import 'package:chotu_admin/model/product_model.dart';
import 'package:chotu_admin/providers/api_services_provider.dart';
import 'package:chotu_admin/utils/api_consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class StoreProductProvider extends ChangeNotifier {

  ApiServicesProvider apiServicesProvider =
  navigatorKey.currentContext!.read<ApiServicesProvider>();

  //< storeID <pageNo,List<ProductModel>>>
  Map<int,Map<int,List<ProductModel>>> storeProductsMap = {};
  PaginationModel? storeProductPagination;

  Future<void> getStoreProducts(int storeId,{int? page = 1}) async{
    try{
      http.Response response = await apiServicesProvider.getRequestResponse(
          APIConstants.getProductByStoreId + '${storeId}'+'?page=${page}');

      print("RESPONSE CODE FOR getStoreProducts ${response.statusCode}");

      if(response.statusCode == 200){
        storeProductPagination = PaginationModel.fromJson(jsonDecode(response.body)['pagination']);
        List<ProductModel> tempProdList = [];

        List<dynamic> dataList = (jsonDecode(response.body))['data'];

        dataList.forEach((prodData) {
          print(prodData);
          ProductModel product = ProductModel.fromJson(prodData);
          tempProdList.add(product);

        });
        if(storeProductsMap[storeId] == null){
          storeProductsMap[storeId] = {};
        }
        storeProductsMap[storeId]![storeProductPagination!.currentPage] = tempProdList;
        print("LENGTH OF PRODUCT ${storeProductsMap[storeId]![storeProductPagination!.currentPage]!.length}");
      }else{
        print("No Products Found");
        print("Error while getting store products: ${response.statusCode}");
        if(storeProductsMap[storeId] == null){
          storeProductsMap[storeId] = {1:[]};
          storeProductPagination = PaginationModel(
              currentPage: 1, lastPage: 1, perPage: 12, total: 0);
        }
      }
      notifyListeners();
    }catch(e){
      print("Exception while getting store products $e");
      if(storeProductsMap[storeId] == null){
        storeProductsMap[storeId] = {1:[]};
        storeProductPagination = PaginationModel(
            currentPage: 1, lastPage: 1, perPage: 12, total: 0);
      }
      notifyListeners();
    }

  }

}