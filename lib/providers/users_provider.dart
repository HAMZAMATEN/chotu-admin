import 'dart:convert';

import 'package:chotu_admin/main.dart';
import 'package:chotu_admin/model/user_model.dart';
import 'package:chotu_admin/providers/api_services_provider.dart';
import 'package:chotu_admin/utils/api_consts.dart';
import 'package:chotu_admin/utils/functions.dart';
import 'package:chotu_admin/utils/toast_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UsersProvider with ChangeNotifier {

  ApiServicesProvider apiServicesProvider = navigatorKey.currentContext!.read<ApiServicesProvider>();

  final List<Map<String, dynamic>> _users = [
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
      "status": 0
    },
    {
      "name": "Brooklyn Simmons",
      "info": "Joined at 25/4/2024 and is a very frequent user",
      "button": "See",
      "status": 0
    },
    {
      "name": "Kathryn Murphy",
      "info": "Joined at 15/12/2024 and is a non frequent user",
      "button": "See",
      "status": 1
    },
  ];

  // Getter for accessing the user list
  List<Map<String, dynamic>> get users => _users;

  // Method to update the status of a user
  void updateStatus(int index, String status) {
    _users[index]['status'] = status;
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  // List of statuses
  final List<String> statuses = ['Blocked','Approved'];

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



  List<UserModel>? allUsersList;

  Future<void> getAllUsers() async{
    try{
      http.Response response = await apiServicesProvider.getRequestResponse(APIConstants.getAllUsers);

      print("RESPONSE CODE FOR getAllUsers ${response.statusCode}");
      if(response.statusCode == 200){
        List<UserModel> tempUsersList = [];
        List<dynamic> dataList = (jsonDecode(response.body))['data'];
        dataList.forEach((shopData){
          UserModel user = UserModel.fromJson(shopData);
          tempUsersList.add(user);
        });
        allUsersList?.clear();
        allUsersList = tempUsersList;
      }
      notifyListeners();
    }catch(e){
      AppFunctions.showToastMessage(message: "Exception while getAllUsers: $e");
    }
  }


  Future<void> updateUserStatus(UserModel userModel) async{
    try{
      http.Response response = await apiServicesProvider.getRequestResponse(APIConstants.updateUserStatus+'${userModel.id}');
      print("RESPONSE CODE FOR updateUserStatus ${response.statusCode}");
      if(response.statusCode == 200){
        UserModel tempModel = userModel;
        int currentStatus = tempModel.status;

        if(currentStatus == 0){
          tempModel.status = 1;
        }else if(currentStatus == 1){
          tempModel.status = 0;
        }

        // Find index of the store in allUsersList
        int index = allUsersList!.indexWhere((store) => store.id == userModel.id);

        if (index != -1) {
          allUsersList![index] = tempModel; // Update the store in the list
        }
        AppFunctions.showToastMessage(message: "User Status Updated Successfully");
      }
      ShowToastDialog.closeLoader();
      notifyListeners();
    }catch(e){
      AppFunctions.showToastMessage(message: "Exception while updateUserStatus: $e");
      ShowToastDialog.closeLoader();
    }
  }

}
