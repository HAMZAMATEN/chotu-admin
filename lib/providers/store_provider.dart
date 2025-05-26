import 'dart:convert';

import 'package:chotu_admin/main.dart';
import 'package:chotu_admin/model/category_model.dart';
import 'package:chotu_admin/model/shop_model.dart';
import 'package:chotu_admin/providers/api_services_provider.dart';
import 'package:chotu_admin/utils/api_consts.dart';
import 'package:chotu_admin/utils/app_constants.dart';
import 'package:chotu_admin/utils/functions.dart';
import 'package:chotu_admin/utils/toast_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class StoreProvider extends ChangeNotifier {
  ApiServicesProvider apiServicesProvider = navigatorKey.currentContext!.read<ApiServicesProvider>();

  List<StoreModel>? allStoresList;
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


  /// adding shop variables

  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  Map<String,dynamic>? storeImageMap;
  Map<String,dynamic>? storeCoverImageMap;

  int? categoryId;

  setImagesMapsToNull(){
    storeImageMap = null ;
    storeCoverImageMap = null ;
    notifyListeners();
  }

  updateCategoryId(int id){
    categoryId = id;
  }

  Future<void> pickStoreImage(BuildContext context) async{
    Map<String,dynamic>? imageFileMap = await AppFunctions().pickImageOnWeb(context);
    if(imageFileMap != null){
      storeImageMap = imageFileMap;
      notifyListeners();
    }
  }
  Future<void> pickStoreCoverImage(BuildContext context) async{
    Map<String,dynamic>? imageFileMap = await AppFunctions().pickImageOnWeb(context);
    if(imageFileMap != null){
      storeCoverImageMap = imageFileMap;
      notifyListeners();
    }
  }


  Future<void> addShopToDataBase(Map<String,dynamic> body,BuildContext context) async{
    try{
      EasyLoading.showToast("Uploading image files");
      final uri = Uri.parse('https://chotuapp.deeptech.pk/api/store'); // 🔁 Replace with your API
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
          const SnackBar(
              content: Text('Shop added successfully!')),
        );
        Navigator.of(context).pop(); // Close the dialog
        getAllStores();
        print('STORE ADDED SUCCESSFULLY');
      } else {
        EasyLoading.dismiss();
        print('Store Addition failed: ${response.statusCode}');
        print('Store Addition failed: ${await response.stream.bytesToString}');
      }

    } catch(e){
      EasyLoading.dismiss();
      print('Store Addition failed: ${e}');
      print("EXCEPTION WHILE ADDING SHOP TO DB");
    }

  }

  setAllStoresToNull(){
    allStoresList = null;
    notifyListeners();
  }





  setSuggestionLoading(val) {
    _suggestionLoading = val;
    notifyListeners();
  }

  Future<void> fetchSuggestions(String query) async {
    setSuggestionLoading(true);
    if (query.isEmpty) return;

    String country =  "PK";

    String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&components=country:$country&key=${AppConstants.googleMapApiKey}";

    final response = await http.get(Uri.parse(url));

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

  setMapController(GoogleMapController controller){
    mapController = controller;
    notifyListeners();
  }


  addMarker(Marker marker){
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

}