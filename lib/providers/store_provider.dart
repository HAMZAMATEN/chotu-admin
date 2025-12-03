import 'dart:convert';

import 'package:chotu_admin/main.dart';
import 'package:chotu_admin/model/category_model.dart';
import 'package:chotu_admin/model/location_iq_model.dart';
import 'package:chotu_admin/model/pagination_model.dart';
import 'package:chotu_admin/model/shop_model.dart';
import 'package:chotu_admin/providers/api_services_provider.dart';
import 'package:chotu_admin/utils/api_consts.dart';
import 'package:chotu_admin/utils/app_constants.dart';
import 'package:chotu_admin/utils/functions.dart';
import 'package:chotu_admin/utils/toast_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class StoreProvider extends ChangeNotifier {
  ApiServicesProvider apiServicesProvider =
      navigatorKey.currentContext!.read<ApiServicesProvider>();

  // List<StoreModel>? allStoresList;
  Map<int, List<StoreModel>?>? pageViseStoresMap = {};
  PaginationModel? storePagination;
  int activeStoresLength = 0;
  int inActiveStoresLength = 0;

  List<CategoryModel>? allCategoriesList;

  //Map Realated Variables
  Set<Marker> markers = {};
  GoogleMapController? mapController;

  // Fetch location suggestions variables
  TextEditingController locationSearchController = TextEditingController();
  String selectedAddress = "";
  List<dynamic> _suggestions = [];

  List<dynamic> get suggestions => _suggestions;

  LatLng _latLng = LatLng(0.0, 0.0);

  LatLng get latLng => _latLng;

  bool _suggestionLoading = false;

  bool get suggestionLoading => _suggestionLoading;

  /// adding shop variables

  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  Map<String, dynamic>? storeImageMap;
  Map<String, dynamic>? storeCoverImageMap;
  int? categoryId;

  Future<void> getAllStores({int? page = 1}) async {
    try {
      http.Response response = await apiServicesProvider
          .getRequestResponse('${APIConstants.getAllStores}?page=${page}');

      print("RESPONSE CODE FOR getAllStores ${response.statusCode}");
      if (response.statusCode == 200) {
        storePagination =
            PaginationModel.fromJson(jsonDecode(response.body)['pagination']);
        List<StoreModel> tempStoresList = [];
        List<dynamic> dataList = (jsonDecode(response.body))['data'];
        dataList.forEach((shopData) {
          StoreModel store = StoreModel.fromJson(shopData);
          tempStoresList.add(store);
        });
        pageViseStoresMap?[storePagination!.currentPage] = tempStoresList;
      }
      notifyListeners();
    } catch (e) {
      AppFunctions.showToastMessage(
          message: "Exception while getAllStores: $e");
    }
  }

  Future<void> getAllCategories() async {
    try {
      http.Response response = await apiServicesProvider
          .getRequestResponse(APIConstants.getAllCategories);
      print("RESPONSE CODE FOR getAllCategories ${response.statusCode}");
      if (response.statusCode == 200) {
        List<CategoryModel> tempCategoryList = [];
        List<dynamic> dataList = (jsonDecode(response.body))['data'];
        dataList.forEach((cat) {
          CategoryModel categoryModel = CategoryModel.fromJson(cat);
          tempCategoryList.add(categoryModel);
        });
        allCategoriesList?.clear();
        allCategoriesList = tempCategoryList;
      }
      notifyListeners();
    } catch (e) {
      AppFunctions.showToastMessage(
          message: "Exception while getAllCategories: $e");
    }
  }

  Future<void> updateStoreStatus(StoreModel storeModel) async {
    try {
      http.Response response = await apiServicesProvider.getRequestResponse(
          APIConstants.updateStoreStatus + '${storeModel.id}');
      print("RESPONSE CODE FOR updateStoreStatus ${response.statusCode}");
      if (response.statusCode == 200) {
        StoreModel tempModel = storeModel;
        int currentStatus = tempModel.status;

        if (currentStatus == 0) {
          tempModel.status = 1;
        } else if (currentStatus == 1) {
          tempModel.status = 0;
        }

        // Find index of the store in allStoresList
        int index = pageViseStoresMap![storePagination!.currentPage]!
            .indexWhere((store) => store.id == storeModel.id);

        if (index != -1) {
          pageViseStoresMap![storePagination!.currentPage]![index] =
              tempModel; // Update the store in the list
        }
        AppFunctions.showToastMessage(
            message: "Store Status Updated Successfully");
      }
      ShowToastDialog.closeLoader();
      notifyListeners();
    } catch (e) {
      AppFunctions.showToastMessage(
          message: "Exception while updateStoreStatus: $e");
      ShowToastDialog.closeLoader();
    }
  }

  setImagesMapsToNull() {
    storeImageMap = null;
    storeCoverImageMap = null;
    notifyListeners();
  }

  updateCategoryId(int id) {
    categoryId = id;
  }

  Future<void> pickStoreImage(BuildContext context) async {
    Map<String, dynamic>? imageFileMap =
        await AppFunctions().pickImageOnWeb(context);
    if (imageFileMap != null) {
      storeImageMap = imageFileMap;
      notifyListeners();
    }
  }

  Future<void> pickStoreCoverImage(BuildContext context) async {
    Map<String, dynamic>? imageFileMap =
        await AppFunctions().pickImageOnWeb(context);
    if (imageFileMap != null) {
      storeCoverImageMap = imageFileMap;
      notifyListeners();
    }
  }

  Future<void> addShopToDataBase(
      Map<String, dynamic> body, BuildContext context) async {
    try {
      print("ADD SHOP BODY IS ");
      print(body);
      EasyLoading.showToast("Uploading image files");
      EasyLoading.show();
      final uri = Uri.parse(APIConstants.addStore); // 🔁 Replace with your API
      final request = await http.MultipartRequest('POST', uri);

      // Add image file
      request.files.add(
        http.MultipartFile.fromBytes(
          'f_img',
          storeImageMap!['image'],
          filename: storeImageMap!['fileName'],
        ),
      );

      // Add image file
      request.files.add(
        http.MultipartFile.fromBytes(
          'c_img',
          storeCoverImageMap!['image'],
          filename: storeCoverImageMap!['fileName'],
        ),
      );

      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Authorization'] = 'Bearer ${AppConstants.authToken}';
      // Add text fields
      request.fields['name'] = body['name'];
      request.fields['category_id'] = body['category_id'];
      request.fields['address'] = body['address'];
      request.fields['longitude'] = body['longitude'];
      request.fields['latitude'] = body['latitude'];
      request.fields['status'] = '1';

      // Send request
      final response = await request.send();

      if (response.statusCode == 201) {
        EasyLoading.dismiss();
        setAllStoresToNull();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Shop added successfully!')),
        );
        Navigator.of(context).pop(); // Close the dialog
        getAllStores();
        clearControllers();
        print('STORE ADDED SUCCESSFULLY');
      } else {
        EasyLoading.dismiss();
        clearControllers();
        Navigator.pop(context);
        AppFunctions.showToastMessage(
            message: "Failed to add shop. Please try again.");
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Failed to add shop. Please try again.')),
        // );
        print('Store Addition failed: ${response.statusCode}');
        print(
            'Store Addition failed: ${await response.stream.bytesToString()}');
      }
    } catch (e) {
      EasyLoading.dismiss();
      clearControllers();
      Navigator.pop(context);
      AppFunctions.showToastMessage(
          message: "Failed to add shop. Please try again.");
      print('Store Addition failed: ${e}');
      print("EXCEPTION WHILE ADDING SHOP TO DB");
    }
  }

  clearControllers() {
    selectedAddress = "";
    latitudeController.text = "";
    longitudeController.text = "";
    storeImageMap = null;
    storeCoverImageMap = null;
    categoryId = null;
    notifyListeners();
  }

  setAllStoresToNull() {
    pageViseStoresMap![storePagination!.currentPage] = [];
    // allStoresList = null;
    notifyListeners();
  }

  setSuggestionLoading(val) {
    _suggestionLoading = val;
    notifyListeners();
  }

  Future<void> fetchSuggestions(String query) async {
    setSuggestionLoading(true);
    if (query.isEmpty) return;

    // String country = "PK";
    //
    // String url =
    //     "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&components=country:$country&key=${AppConstants.googleMapApiKey}";
    //
    // final response = await http.get(Uri.parse(url));
    final String apiKey = AppConstants.googleMapApiKey;
    print("API KEY IS ${apiKey}");
    print("Query IS ${query}");
    http.Response response = await apiServicesProvider.postRequestResponse(
        'https://firebase-notifications-topaz.vercel.app/api/places',
        body: {"apiKey": "${apiKey}", "query": "${query}"});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("SUGGESTIONS RESPONSE IS ${data}");
      _suggestions = [];
      _suggestions = (data["predictions"] as List);
      notifyListeners();
      setSuggestionLoading(false);
    } else {
      print("Error fetching suggestions: ${response.body}");
      _suggestions = [];
      setSuggestionLoading(false);
    }
  }

  // Fetch lat & lng using place_id
  Future<LatLng?> getPlaceDetails(String placeId) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=${AppConstants.googleMapApiKey}";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final location = data["result"]["geometry"]["location"];
      double lat = location["lat"];
      double lng = location["lng"];

      _latLng = LatLng(lat, lng);
      print("Selected Location - $_latLng");
      return _latLng;
      notifyListeners();
    } else {
      print("Error fetching place details: ${response.body}");
      return null;
    }
  }

  updateLatLang(LatLng val){
    _latLng = val;
    notifyListeners();
  }

  setMapController(GoogleMapController controller) {
    mapController = controller;
    notifyListeners();
  }

  addMarker(Marker marker) {
    markers.removeWhere((m) => m.markerId == MarkerId("selected"));
    markers.add(marker);
    latitudeController.text = latLng.latitude.toString();
    longitudeController.text = latLng.longitude.toString();
    print("MARKER IS ADDED ${markers}");
    notifyListeners();
  }

  clearSuggestions() {
    locationSearchController.clear();
    _suggestions = [];
    notifyListeners();
  }

  /// searching function
  List<StoreModel>? searchedStoresList;
  bool isSearching = false;
  PaginationModel? searchPagination;

  Future<void> searchStore(String input, {int? page = 1}) async {
    try {
      print("input is");
      print(input);
      updateIsSearchingValue(true);
      if (page == 1) {
        searchedStoresList = [];
      }
      http.Response response = await apiServicesProvider.getRequestResponse(
          '${APIConstants.searchStore}${input}?page=${page}');

      print("RESPONSE CODE FOR searchStore ${response.statusCode}");
      print("RESPONSE IS ${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        searchPagination =
            PaginationModel.fromJson(jsonDecode(response.body)['pagination']);
        List<StoreModel> tempStoresList = [];
        List<dynamic> dataList = (jsonDecode(response.body))['data'];
        dataList.forEach((shopData) {
          StoreModel store = StoreModel.fromJson(shopData);
          tempStoresList.add(store);
        });
        searchedStoresList = searchedStoresList! + tempStoresList;
      } else {
        print("No Stores Found");
        print("Error while searching store: ${response.statusCode}");
        searchedStoresList = [];
      }
      notifyListeners();
    } catch (e) {
      print("EXCEPTION WHILE SEARCHING STORE ${e}");
      searchedStoresList = [];
      notifyListeners();
    }
  }

  updateIsSearchingValue(bool val) {
    isSearching = val;
    notifyListeners();
  }

  resetSearchStoreList() {
    searchedStoresList = null;
    notifyListeners();
  }

  Future<void> updateShopToDataBase(
      String storeId, Map<String, dynamic> body, BuildContext context) async {
    try {
      print("Update SHOP BODY IS ");
      print(body);
      EasyLoading.showToast("Uploading image files");
      EasyLoading.show();
      final uri = Uri.parse(APIConstants.updateStore + '$storeId');
      final request = await http.MultipartRequest('POST', uri);

      if (storeImageMap != null) {
        // Add f_image file if it is not equal to null
        request.files.add(
          http.MultipartFile.fromBytes(
            'f_img',
            storeImageMap!['image'],
            filename: storeImageMap!['fileName'],
          ),
        );
      }

      if (storeCoverImageMap != null) {
        // Add c_image file if it is not equal to null
        request.files.add(
          http.MultipartFile.fromBytes(
            'c_img',
            storeCoverImageMap!['image'],
            filename: storeCoverImageMap!['fileName'],
          ),
        );
      }

      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Authorization'] = 'Bearer ${AppConstants.authToken}';

      // Add text fields
      request.fields['name'] = body['name'];
      request.fields['category_id'] = body['category_id'];
      request.fields['address'] = body['address'];
      request.fields['longitude'] = body['longitude'];
      request.fields['latitude'] = body['latitude'];
      request.fields['status'] = '1';

      // Send request
      final response = await request.send();

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        setAllStoresToNull();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Shop Updated successfully!')),
        );
        Navigator.of(context).pop(); // Close the dialog
        getAllStores(page: storePagination!.currentPage);
        clearControllers();
        print('STORE ADDED SUCCESSFULLY');
      } else {
        EasyLoading.dismiss();
        clearControllers();
        Navigator.pop(context);
        AppFunctions.showToastMessage(
            message: "Failed to add shop. Please try again.");
        print('Store Updation failed: ${response.statusCode}');
        print(
            'Store Updation failed: ${await response.stream.bytesToString()}');
      }
    } catch (e) {
      EasyLoading.dismiss();
      clearControllers();
      Navigator.pop(context);
      AppFunctions.showToastMessage(
          message: "Failed to update shop. Please try again.");
      print('Store Updation failed: ${e}');
      print("EXCEPTION WHILE Updation SHOP TO DB");
    }
  }


  List<LocationIQPlace> suggestionList = [];
  Future<void> fetchLocationIQPlaces({required String query}) async{
    try{
      String url =
          "${APIConstants.getAutoCompletePlaces}key=${AppConstants.kLocationKey}&q=${query}&limit=10&dedupe=1";

      final response = await http.get(Uri.parse(url));
      
      debugPrint("Status Code of fetchLocationIQPlaces ${response.statusCode}");
      
      if(response.statusCode == 200){
        suggestionList = [];
        List<dynamic> dataList = jsonDecode(response.body);
        for(var data in dataList){
          LocationIQPlace place = LocationIQPlace.fromJson(data);
          suggestionList.add(place);
        }
      }else{
        suggestionList = [];
      }
      print("SUGGESTION LIST LENGTH ${suggestionList.length}");
      notifyListeners();
    }catch(e){
      debugPrint("Exception whilte fetchLocationIQPlaces ${e}");
    }
  }

  clearPlacesSuggestions(){
    locationSearchController.clear();
    suggestionList = [];
    notifyListeners();
  }

}
