import 'dart:convert';

import 'package:chotu_admin/model/all_product_images_model.dart';
import 'package:chotu_admin/utils/toast_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import '../../main.dart';
import '../../utils/api_consts.dart';
import '../../utils/app_constants.dart';
import '../../utils/functions.dart';
import '../api_services_provider.dart';

class AllProductImageProvider extends ChangeNotifier {
  AllProductImageProvider() {
    fetchAllProductImages();
  }

  ApiServicesProvider apiServicesProvider =
      navigatorKey.currentContext!.read<ApiServicesProvider>();

  AllProductImagesModel? allProductImagesModel;

  ImagePicker _imagePicker = ImagePicker();

  List<String> filteredList = [];

  List<XFile> selectedImagesList = [];

  TextEditingController searchController = TextEditingController();

  Future<void> pickMultipleImagesFromGallery() async {
    try {
      final List<XFile>? selectedImages = await _imagePicker.pickMultiImage();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        // Handle the selected images
        selectedImagesList = selectedImages;
        notifyListeners();
        await uploadSelectedImages();
      } else {
        print('No images selected.');
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  Future<void> fetchAllProductImages() async {
    try {
      var response = await apiServicesProvider
          .getRequestResponse(APIConstants.fetchProductImages);

      print("Response of getAllFaqs is ${response.body}");
      print("Response Status of getAllFaqs is ${response.statusCode}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        allProductImagesModel = AllProductImagesModel.fromJson(data);
        notifyListeners();
      } else {}
      notifyListeners();
    } catch (e) {
      AppFunctions.showToastMessage(
          message: 'Error fetching product images: $e');
    }
  }

  Future<void> uploadSelectedImages() async {
    ShowToastDialog.showLoader("Uploading...");
    try {
      var uri = Uri.parse(APIConstants.uploadProductImages);

      var request = http.MultipartRequest("POST", uri);
      request.headers.addAll({
        "Authorization": "Bearer ${AppConstants.authToken}",
        "Accept": "application/json",
      });
      // Attach images
      for (var image in selectedImagesList) {
        var fileBytes = await image.readAsBytes();
        var multipartFile = http.MultipartFile.fromBytes(
          'images[]', // field name expected by backend
          fileBytes,
          filename: image.name,
        );
        request.files.add(multipartFile);
      }

      // Send request
      var response = await request.send();

      if (response.statusCode == 201) {
        AppFunctions.showToastMessage(message: "Images uploaded successfully!");
        fetchAllProductImages();
      } else {
        AppFunctions.showToastMessage(
            message: "Upload failed: ${response.statusCode}");
      }
    } catch (e) {
      AppFunctions.showToastMessage(
          message: 'Error uploading product images: $e');
    } finally {
      ShowToastDialog.closeLoader();
    }
  }

  void searchImages() {
    String query = searchController.text.toLowerCase();

    // Ensure data exists
    if (allProductImagesModel == null ||
        allProductImagesModel!.data == null ||
        allProductImagesModel!.data!.urls.isEmpty) {
      filteredList = [];
      notifyListeners();
      return;
    }

    // Filter the list properly
    filteredList = allProductImagesModel!.data!.urls
        .where((e) => e.toLowerCase().contains(query))
        .toList();

    notifyListeners();
  }
}
