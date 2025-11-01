import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:chotu_admin/generated/assets.dart';
import 'package:chotu_admin/main.dart';
import 'package:chotu_admin/model/pagination_model.dart';
import 'package:chotu_admin/model/product_model.dart';
import 'package:chotu_admin/model/shop_analytics_model.dart';
import 'package:chotu_admin/model/shop_model.dart';
import 'package:chotu_admin/providers/api_services_provider.dart';
import 'package:chotu_admin/utils/api_consts.dart';
import 'package:chotu_admin/utils/app_constants.dart';
import 'package:chotu_admin/utils/functions.dart';
import 'package:chotu_admin/utils/toast_dialogue.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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

      debugPrint("RESPONSE CODE FOR getStoreProducts ${response.statusCode}");

      if (response.statusCode == 200) {
        storeProductPagination =
            PaginationModel.fromJson(jsonDecode(response.body)['pagination']);
        List<ProductModel> tempProdList = [];

        List<dynamic> dataList = (jsonDecode(response.body))['data'];

        dataList.forEach((prodData) {
          ProductModel product = ProductModel.fromJson(prodData);
          tempProdList.add(product);
        });
        if (storeProductsMap[storeId] == null) {
          storeProductsMap[storeId] = {};
        }

        storeProductsMap[storeId]![storeProductPagination!.currentPage] =
            tempProdList.toSet().toList();
      } else {
        print("Error while getting store products: ${response.statusCode}");
        if (storeProductsMap[storeId] == null) {
          storeProductsMap[storeId] = {1: []};
          storeProductPagination = PaginationModel(
              currentPage: 1, lastPage: 1, perPage: 12, total: 0);
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Exception while getting store products $e");
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

      debugPrint("RESPONSE CODE FOR getStoreAnalytics ${response.statusCode}");
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
      debugPrint("Exception while getting store analytics $e");
      notifyListeners();
    }
  }

  Future<void> pickProductImage(BuildContext context) async {
    Map<String, dynamic>? imageFileMap =
        await AppFunctions().pickImageOnWeb(context);
    if (imageFileMap != null) {
      print("PICKED IMAGE FILE MAP IS ${imageFileMap}");
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
        debugPrint('Product ADDED SUCCESSFULLY');
      } else {
        AppFunctions.showToastMessage(
            message: "Failed to add product. Please try again.");
        debugPrint('Product Addition failed: ${response.statusCode}');
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
          message: "Failed to add product. Please try again.");
      debugPrint("EXCEPTION WHILE ADDING Product TO DB ${e}");
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
      debugPrint("RESPONSE CODE FOR updateStoreStatus ${response.statusCode}");
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
        debugPrint(
            "Error while updating product status: ${response.statusCode}");
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
      debugPrint("RESPONSE CODE FOR deleteProduct ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("Product Deleted Successfully");
        // Find index of the store in allStoresList
        int index = storeProductsMap[product.store.id]![
                storeProductPagination!.currentPage]!
            .indexWhere((prod) => prod.id == product.id);

        if (index != -1) {
          storeProductsMap[product.store.id]![
                  storeProductPagination!.currentPage]!
              .removeAt(index);
        }
        AppFunctions.showToastMessage(message: "Product Deleted Successfully");
      } else {
        AppFunctions.showToastMessage(
            message: "Failed to delete product . Please try again.");
        debugPrint("Error while deleting product : ${response.statusCode}");
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
      EasyLoading.showToast("Uploading image files");
      EasyLoading.show();
      final uri = Uri.parse(APIConstants.updateProduct +
          '${body['id']}'); // 🔁 Replace with your API
      final request = await http.MultipartRequest('POST', uri);

      // Add image file if user picked a new one
      if (productImageMap != null) {
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
        debugPrint('Product Updated SUCCESSFULLY');
      } else {
        AppFunctions.showToastMessage(
            message: "Failed to Updated product. Please try again.");
        debugPrint('Product Updation failed: ${response.statusCode}');
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
      debugPrint("EXCEPTION WHILE updating Product TO DB ${e}");
    }
  }

  List<ProductModel>? searchedProducts = null;

  Future<void> searchProductByName(
      {required String searchText, required String storeId}) async {
    try {
      http.Response response = await apiServicesProvider.getRequestResponse(
          APIConstants.searchProduct + 'name=${searchText}&shopId=${storeId}');

      debugPrint(
          "RESPONSE CODE FOR searchProductByName ${response.statusCode}");
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
      debugPrint("Exception while getting store analytics $e");
      notifyListeners();
    }
  }

  clearSearchProductsList() {
    searchedProducts = null;
    notifyListeners();
  }

  /// Excel Function for Product for a Specific Store

  Future<void> pickAndUploadExcel(
      BuildContext context, StoreModel store) async {
    try {
      // Step 1: Pick Excel file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
        withData: true,
      );

      if (result == null) {
        EasyLoading.showToast("No file selected");
        return;
      }

      Uint8List? bytes = result.files.single.bytes;
      if (bytes == null) {
        EasyLoading.showToast("Unable to read file");
        return;
      }

      // 🆕 Load default fallback image once
      final Uint8List defaultImageBytes = (await rootBundle.load(
        Assets.imagesImageNoImage,
      ))
          .buffer
          .asUint8List();

      // Step 2: Decode XLSX (ZIP)
      final archive = ZipDecoder().decodeBytes(bytes);

      List<Uint8List> imageBytesList = [];
      List<String> imageNames = [];

      // Step 3: Extract images from xl/media/
      for (final file in archive) {
        if (file.isFile && file.name.startsWith('xl/media/')) {
          String imageName = file.name.split('/').last;
          Uint8List imageBytes = file.content as Uint8List;
          debugPrint("Extracted image: $imageName, size: ${imageBytes.length}");
          imageBytesList.add(imageBytes);
          imageNames.add(imageName);
        }
      }

      // Combine names and bytes into pairs
      List<MapEntry<String, Uint8List>> pairedList = [];
      for (int i = 0; i < imageNames.length; i++) {
        pairedList.add(MapEntry(imageNames[i], imageBytesList[i]));
      }

      // Sort by file name naturally
      pairedList.sort((a, b) {
        final regex = RegExp(r'(\d+)');
        final aNum = int.tryParse(regex.firstMatch(a.key)?.group(0) ?? '') ?? 0;
        final bNum = int.tryParse(regex.firstMatch(b.key)?.group(0) ?? '') ?? 0;

        int numCompare = aNum.compareTo(bNum);
        if (numCompare != 0) return numCompare;
        return a.key.compareTo(b.key);
      });

      imageNames
        ..clear()
        ..addAll(pairedList.map((e) => e.key));
      imageBytesList
        ..clear()
        ..addAll(pairedList.map((e) => e.value));

      print("IMAGES NAME ${imageNames}");
      imageBytesList.forEach((b) => print(b.length));

      // Step 4: Decode Excel
      var excel = Excel.decodeBytes(bytes);
      var sheet = excel.tables[excel.tables.keys.first];

      if (sheet == null) {
        EasyLoading.showToast("No data found in Excel file");
        return;
      }

      int total = sheet.maxRows - 1;
      int successCount = 0;
      int failCount = 0;

      EasyLoading.show(status: "Starting upload...");

      print("SHEET LENGTH::::${sheet.rows.length}");

      final usedImages = <String, List<int>>{};

      for (int i = 1; i < sheet.rows.length; i++) {
        try {
          var row = sheet.rows[i];
          String name = row[0]?.value.toString() ?? '';
          String categoryId = row[1]?.value.toString() ?? '1';
          String brand = row[2]?.value.toString() ?? '';
          String price = row[3]?.value.toString() ?? '';
          String discountPrice = row[4]?.value.toString() ?? '';
          String unit = row[5]?.value.toString() ?? '';
          String unitValue = row[6]?.value.toString() ?? '';
          String description = row[7]?.value.toString() ?? '';

          if (name.isEmpty) {
            debugPrint("Skipping row $i due to missing name");
            continue;
          }

          // 🖼 Pick image (or fallback to default)
          Uint8List imageBytes = (i - 1) < imageBytesList.length
              ? imageBytesList[i - 1]
              : defaultImageBytes;

          String fileName = (i - 1) < imageNames.length
              ? imageNames[i - 1]
              : "default-image.jpeg";

          // 🧾 Log matching
          if (imageBytes == defaultImageBytes) {
            debugPrint("⚠️ Row $i using default image");
          } else {
            debugPrint("✅ Row $i matched with image: $fileName");
            usedImages.putIfAbsent(fileName, () => []).add(i);
          }

          Map<String, dynamic> body = {
            "name": name,
            "category_id": categoryId,
            "brand": brand,
            "price": price,
            "discount_price": discountPrice,
            "unit": unit,
            "unit_value": unitValue,
            "description": description,
            "store_id": "${store.id}",
          };

          Map<String, dynamic>? productMap = {
            'image': imageBytes,
            'fileName': fileName,
          };

          bool productAdded =
              await addExcelProductToDataBase(body, context, productMap);

          print("PRODUCT ADDED AT INDEX::::$i");
          if (productAdded == true) {
            successCount++;
          } else {
            failCount++;
          }

          EasyLoading.showProgress(
            successCount / total,
            status: "Uploaded $successCount / $total",
          );
        } catch (e) {
          debugPrint("Error uploading row $i: $e");
          failCount++;
          continue;
        }
      }

      for (final entry in usedImages.entries) {
        if (entry.value.length > 1) {
          debugPrint(
              "⚠️ Image '${entry.key}' used in multiple rows: ${entry.value.join(', ')}");
        }
      }

      debugPrint("====== Excel Image Matching Summary ======");
      debugPrint("Total images extracted: ${imageNames.length}");
      debugPrint("Total rows processed: ${sheet.maxRows - 1}");
      debugPrint(
          "Duplicate image references: ${usedImages.entries.where((e) => e.value.length > 1).length}");
      debugPrint("==========================================");

      EasyLoading.dismiss();
      EasyLoading.showToast(
          "Upload complete. Success: $successCount, Failed: $failCount");
      EasyLoading.show(status: "Fetching New Products");
      await getStoreProducts(storeId: store.id!);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      debugPrint("EXCEL UPLOAD ERROR: $e");
      EasyLoading.showToast("Error: ${e.toString()}");
    }
  }

  Future<bool> addExcelProductToDataBase(Map<String, dynamic> body,
      BuildContext context, Map<String, dynamic>? productMap) async {
    try {
      final uri =
          Uri.parse(APIConstants.addProduct); // 🔁 Replace with your API
      final request = await http.MultipartRequest('POST', uri);

      // Add image file
      // if (productMap != null || productMap != {}) {
      //
      //   print("ADDING FILE::::");
      //
      //   request.files.add(
      //     http.MultipartFile.fromBytes(
      //       'img',
      //       productMap?['image'] ?? "",
      //       filename: productMap?['fileName'] ?? "",
      //     ),
      //   );
      // }

      if (productMap != null && productMap.isNotEmpty) {
        var imageBytes = productMap['image'];

        // If it's base64 String → decode it
        if (imageBytes is String) {
          imageBytes = base64Decode(imageBytes);
        }

        if (imageBytes is List<int> && imageBytes.isNotEmpty) {
          print("ADDING FILE::::");
          request.files.add(
            http.MultipartFile.fromBytes(
              'img',
              imageBytes,
              filename: productMap['fileName'] ?? "product_image.png",
            ),
          );
        } else {
          debugPrint("⚠️ No valid image bytes found for product.");
        }
      }

      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Authorization'] = 'Bearer ${AppConstants.authToken}';
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
        debugPrint('Product Added Successfully');
        return true;
      } else {
        debugPrint(
            'Product Addition failed: ${await response.stream.bytesToString()}');
        return false;
      }
    } catch (e) {
      debugPrint("EXCEPTION WHILE ADDING Product TO DB ${e}");
      return false;
    }
  }
}
