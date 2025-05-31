import 'dart:convert';

import 'package:chotu_admin/model/all_riders_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../main.dart';
import '../utils/api_consts.dart';
import '../utils/app_constants.dart';
import '../utils/functions.dart';
import '../utils/toast_dialogue.dart';
import 'api_services_provider.dart';

class RidersProvider with ChangeNotifier {
  ApiServicesProvider apiServicesProvider =
      navigatorKey.currentContext!.read<ApiServicesProvider>();

  final List<Map<String, dynamic>> _riders = [
    {
      "name": "Eleanor Pena",
      "info": "Joined at 25/4/2024 and is a very frequent user",
      "button": "See",
      "status": 1
    },
    {
      "name": "Wade Warren",
      "info": "Joined at 15/12/2024 and is a non frequent user",
      "button": "See",
      "status": 2
    },
    {
      "name": "Brooklyn Simmons",
      "info": "Joined at 25/4/2024 and is a very frequent user",
      "button": "See",
      "status": 1
    },
    {
      "name": "Kathryn Murphy",
      "info": "Joined at 15/12/2024 and is a non frequent user",
      "button": "See",
      "status": 1
    },
  ];

  // Getter for accessing the user list
  List<Map<String, dynamic>> get riders => _riders;

  // Method to update the status of a user
  void updateStatus(int index, String status) {
    _riders[index]['status'] = status;
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  // List of statuses
  final List<String> statuses = [
    // 'Disapprove',
    'Blocked',
    'Approved',
  ];

  // Get background color based on status
  Color getStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.green.withOpacity(0.4);
      case 0:
        //   return Colors.orange.withOpacity(0.4);
        // case 3:
        return Colors.red.withOpacity(0.4);
      default:
        return Colors.blue.withOpacity(0.4); // Default for 'Pending'
    }
  }

  // Get text color based on status
  Color getTextColor(int status) {
    return status == 0 ? Colors.white : Colors.black;
  }

  Color getStatusIndicatorColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      // case 'Disapprove':
      //   return Colors.orange;
      case 'Blocked':
        return Colors.red;
      default:
        return Colors.blue; // Default for 'Pending'
    }
  }

  List<Rider>? allRidersList;
  List<Rider>? filterRidersList;

  Pagination? pagination;

  int _currentPage = 1;

  int get currentPage => _currentPage;

  void setCurrentPage(val) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _currentPage = val;

      notifyListeners();
    });
  }

  Future<void> getAllRiders(int page) async {
    setCurrentPage(page);
    allRidersList = null;
    filterRidersList = null;
    searchController.clear();
    try {
      http.Response response = await apiServicesProvider
          .getRequestResponse("${APIConstants.getAllRiders}?page=$page");

      print("RESPONSE CODE FOR getAllRiders ${response.statusCode}");
      if (response.statusCode == 200) {
        AllRidersModel riderModel =
            AllRidersModel.fromJson(jsonDecode(response.body));
        List<Rider> tempRidersList = [];

        List<dynamic> dataList = (jsonDecode(response.body))['data'];

        pagination = riderModel.pagination;

        setCurrentPage(pagination!.currentPage ?? 1);

        dataList.forEach((shopData) {
          Rider user = Rider.fromJson(shopData);
          tempRidersList.add(user);
        });
        allRidersList?.clear();

        allRidersList = tempRidersList;
        filterRidersList?.clear();

        filterRidersList = tempRidersList;
      }
      notifyListeners();
    } catch (e) {
      print('Exception while getAllUsers: $e');
      AppFunctions.showToastMessage(message: "Exception while getAllUsers: $e");
    }
  }

  /// update rider status

  Future<void> updateRiderStatus(Rider rider) async {
    try {
      http.Response response = await apiServicesProvider
          .getRequestResponse(APIConstants.updateRiderStatus + '${rider.id}');
      print("RESPONSE CODE FOR updateUserStatus ${response.statusCode}");
      if (response.statusCode == 200) {
        Rider tempModel = rider;
        int currentStatus = tempModel.status!;

        if (currentStatus == 0) {
          tempModel.status = 1;
        } else if (currentStatus == 1) {
          tempModel.status = 0;
        }

        // Find index of the store in allUsersList
        int index = allRidersList!.indexWhere((store) => store.id == rider.id);

        if (index != -1) {
          allRidersList![index] = tempModel; // Update the store in the list
        }
        AppFunctions.showToastMessage(
            message: "User Status Updated Successfully");
      }
      ShowToastDialog.closeLoader();
      notifyListeners();
    } catch (e) {
      AppFunctions.showToastMessage(
          message: "Exception while updateUserStatus: $e");
      ShowToastDialog.closeLoader();
    }
  }

  /// add rider

  // Controllers for input fields
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final cnicController = TextEditingController();
  final cityController = TextEditingController();
  final flatSocietyController = TextEditingController();
  final flatHouseNoController = TextEditingController();
  final floorController = TextEditingController();
  final addressController = TextEditingController();

  List<dynamic> placePredictions = [];
  bool isSearching = false;

  Future<void> getPlacePredictions(String input) async {
    if (input.isEmpty) {
      placePredictions = [];
      notifyListeners();
      return;
    }

    final String apiKey = AppConstants.googleMapApiKey;
    final String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final String request =
        '$baseURL?input=$input&key=$apiKey&components=country:pk';

    final response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      placePredictions = data['predictions'];
      notifyListeners();
    } else {
      print('Failed to fetch predictions: ${response.body}');
    }
  }

  Future<Map<String, dynamic>?> getPlaceDetails(String placeId) async {
    final apiKey =
        AppConstants.googleMapApiKey; // Use your actual Google API key
    final url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return data['result']; // This contains the latitude and longitude
      }
    }
    return null;
  }

  Map<String, dynamic>? storeRiderImage;

  setImagesMapsToNull() {
    storeRiderImage = null;
    notifyListeners();
  }

  Future<void> pickRiderImage(BuildContext context) async {
    Map<String, dynamic>? imageFileMap =
        await AppFunctions().pickImageOnWeb(context);
    if (imageFileMap != null) {
      storeRiderImage = imageFileMap;
      notifyListeners();
    }
  }

  String latitude = "";
  String longitude = "";

  void setLatLang(var lat, lang) {
    latitude = lat.toString();
    longitude = lang.toString();
    notifyListeners();
  }

  Future<void> addRiderToDataBase(BuildContext context) async {
    try {
      // EasyLoading.showToast("Uploading Rider Data");
      ShowToastDialog.showLoader("Uploading Rider Data");
      final uri = Uri.parse(
          'https://chotuapp.deeptech.pk/api/register/rider'); // 🔁 Replace with your API
      final request = await http.MultipartRequest('POST', uri);

      // Add image file
      if (storeRiderImage != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'profile_image',
            storeRiderImage!['image'],
            filename: storeRiderImage!['fileName'],
          ),
        );
      }

      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Authorization'] = 'Bearer ${AppConstants.authToken}';
      // Add text fields
      request.fields['nic'] = cnicController.text; // "0023456789121"
      request.fields['name'] = nameController.text; // "rider"
      request.fields['email'] = emailController.text; // "i@am.rider31"
      request.fields['password'] = passwordController.text; // "rider123"
      request.fields['mobile_no'] = phoneController.text; // "12345678912"
      request.fields['city'] = cityController.text; // "Lahore"
      request.fields['address'] =
          addressController.text; // "123, Some Street, Lahore, Pakistan"
      request.fields['latitude'] = latitude
          .toString(); // or from picked place: latLng.latitude.toString()
      request.fields['longitude'] = longitude
          .toString(); // or from picked place: latLng.longitude.toString()
      request.fields['flat_socity'] =
          flatSocietyController.text; // "Some Society Name"
      request.fields['flat_house_no'] = flatHouseNoController.text; // "12B"
      request.fields['floor'] = floorController.text; // "3rd"

      // Send request
      final response = await request.send();

      if (response.statusCode == 200) {
        await getAllRiders(_currentPage);
        Navigator.of(context).pop(); // Close the dialog
        EasyLoading.dismiss();
        resetAllFields();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rider added successfully!')),
        );
        print('RIDER ADDED SUCCESSFULLY');
      } else {
        final responseBody = await response.stream.bytesToString();
        print('Rider Addition failed: $responseBody');

        try {
          final decodedBody = json.decode(responseBody);

          if (decodedBody['errors'] != null) {
            final errors = decodedBody['errors'] as Map<String, dynamic>;

            String errorMessage = '';

            errors.forEach((key, value) {
              if (value is List && value.isNotEmpty) {
                errorMessage += '${value[0]}\n';
              }
            });

            ShowToastDialog.showToast(errorMessage.trim());
          } else {
            ShowToastDialog.showToast("Failed to add rider. Please try again.");
          }
        } catch (e) {
          print('Error parsing response: $e');
          ShowToastDialog.showToast("Unexpected error occurred.");
        }
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      print('Rider Addition failed: ${e}');
      print("EXCEPTION WHILE ADDING RIDER TO DB");
      ShowToastDialog.showToast(
          "EXCEPTION WHILE ADDING RIDER. PLEASE TRY AGAIN LATER.");
    }
  }

  void resetAllFields() {
    emailController.clear();
    nameController.clear();
    passwordController.clear();
    phoneController.clear();
    cnicController.clear();
    cityController.clear();
    flatSocietyController.clear();
    flatHouseNoController.clear();
    floorController.clear();
    addressController.clear();

    placePredictions = [];
    isSearching = false;

    storeRiderImage = null;

    notifyListeners();
  }

  /// remove rider

  Future<void> removeRiderFromDataBase(BuildContext context, String id) async {
    try {
      // EasyLoading.showToast("Uploading Rider Data");
      ShowToastDialog.showLoader("Removing Rider Data");

      http.Response response = await apiServicesProvider
          .getRequestResponse("${APIConstants.removeRider}$id");

      if (response.statusCode == 200) {
        Navigator.of(context).pop(); // Close the dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rider removed successfully!')),
        );
        EasyLoading.dismiss();
        await getAllRiders(_currentPage);

        print('RIDER REMOVED SUCCESSFULLY');
      } else {
        final responseBody = await response.body;
        print('Rider Addition failed: $responseBody');

        ShowToastDialog.showToast("Failed to remove rider. Please try again.");

        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      print('Rider Addition failed: ${e}');
      print("EXCEPTION WHILE ADDING RIDER TO DB");
      ShowToastDialog.showToast(
          "EXCEPTION WHILE REMOVING RIDER. PLEASE TRY AGAIN LATER.");
    }
  }

  /// update rider data

  var imageUrl;

  void getRiderUpdateData(Rider rider) {
    emailController.text = rider.email ?? "";
    nameController.text = rider.name ?? "";
    passwordController.text = rider.password ?? "";
    phoneController.text = rider.mobileNo ?? "";
    cnicController.text = rider.nic ?? "";
    cityController.text = rider.city ?? "";
    flatSocietyController.text = rider.flatSocity ?? "";
    flatHouseNoController.text = rider.flatHouseNo ?? "";
    floorController.text = rider.floor ?? "";
    addressController.text = rider.fullAddress ?? "";
    imageUrl = rider.profileImage ?? "";
    notifyListeners();
  }

  Future<void> updateRider(BuildContext context, String id) async {
    try {
      // EasyLoading.showToast("Uploading Rider Data");
      ShowToastDialog.showLoader("Updating Rider Data");
      final uri = Uri.parse(
          'https://chotuapp.deeptech.pk/api/update/rider/$id'); // 🔁 Replace with your API
      final request = await http.MultipartRequest('POST', uri);

      // Add image file
      if (storeRiderImage != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'profile_image',
            storeRiderImage!['image'],
            filename: storeRiderImage!['fileName'],
          ),
        );
      }

      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Authorization'] = 'Bearer ${AppConstants.authToken}';
      // Add text fields
      request.fields['nic'] = cnicController.text; // "0023456789121"
      request.fields['name'] = nameController.text; // "rider"
      request.fields['email'] = emailController.text; // "i@am.rider31"
      request.fields['password'] = passwordController.text; // "rider123"
      request.fields['mobile_no'] = phoneController.text; // "12345678912"
      request.fields['city'] = cityController.text; // "Lahore"
      request.fields['address'] =
          addressController.text; // "123, Some Street, Lahore, Pakistan"
      request.fields['latitude'] = latitude
          .toString(); // or from picked place: latLng.latitude.toString()
      request.fields['longitude'] = longitude
          .toString(); // or from picked place: latLng.longitude.toString()
      request.fields['flat_socity'] =
          flatSocietyController.text; // "Some Society Name"
      request.fields['flat_house_no'] = flatHouseNoController.text; // "12B"
      request.fields['floor'] = floorController.text; // "3rd"

      // Send request
      final response = await request.send();

      if (response.statusCode == 200) {
        Navigator.of(context).pop(); // Close the dialog
        EasyLoading.dismiss();
        resetAllFields();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rider updated successfully!')),
        );
        await getAllRiders(_currentPage);
        print('RIDER ADDED SUCCESSFULLY');
      } else {
        final responseBody = await response.stream.bytesToString();
        print('Rider Addition failed: $responseBody');

        try {
          final decodedBody = json.decode(responseBody);

          if (decodedBody['errors'] != null) {
            final errors = decodedBody['errors'] as Map<String, dynamic>;

            String errorMessage = '';

            errors.forEach((key, value) {
              if (value is List && value.isNotEmpty) {
                errorMessage += '${value[0]}\n';
              }
            });

            ShowToastDialog.showToast(errorMessage.trim());
          } else {
            ShowToastDialog.showToast(
                "Failed to update rider. Please try again.");
          }
        } catch (e) {
          print('Error parsing response: $e');
          ShowToastDialog.showToast("Unexpected error occurred.");
        }
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      print('Rider Addition failed: ${e}');
      print("EXCEPTION WHILE ADDING RIDER TO DB");
      ShowToastDialog.showToast(
          "EXCEPTION WHILE UPDATING RIDER. PLEASE TRY AGAIN LATER.");
    }
  }

  /// search riders

  var searchController = TextEditingController();

  bool searchLoading = false;

  void setSearchLoading(val) {
    searchLoading = val;
    notifyListeners();
  }

  Future<void> searchRiders(String val) async {
    if (val.isNotEmpty) {
      setSearchLoading(true);
      try {
        http.Response response = await apiServicesProvider
            .getRequestResponse("${APIConstants.searchRiders}?name=$val");

        print("RESPONSE CODE FOR searchRiders ${response.statusCode}");
        if (response.statusCode == 200) {
          List<Rider> tempRidersList = [];

          List<dynamic> dataList = (jsonDecode(response.body))['data'];

          dataList.forEach((shopData) {
            Rider user = Rider.fromJson(shopData);
            tempRidersList.add(user);
          });
          filterRidersList?.clear();

          filterRidersList = tempRidersList;
          notifyListeners();
          setSearchLoading(false);
        } else {
          setSearchLoading(false);
        }
      } catch (e) {
        print('Exception while searchRiders: $e');
        AppFunctions.showToastMessage(
            message: "Exception while searchRiders: $e");
        setSearchLoading(false);
      }
    } else {
      getAllRiders(_currentPage);
    }
  }
}
