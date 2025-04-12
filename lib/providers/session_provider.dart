import 'dart:convert';

import 'package:chotu_admin/main.dart';
import 'package:chotu_admin/model/admin_user_model.dart';
import 'package:chotu_admin/providers/api_services_provider.dart';
import 'package:chotu_admin/screens/sidebar/side_bar_screen.dart';
import 'package:chotu_admin/utils/api_consts.dart';
import 'package:chotu_admin/utils/app_constants.dart';
import 'package:chotu_admin/utils/functions.dart';
import 'package:chotu_admin/utils/hive_prefrences.dart';
import 'package:chotu_admin/utils/toast_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SessionProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  AdminModel? currentAdmin;

  ApiServicesProvider apiServicesProvider =
      navigatorKey.currentContext!.read<ApiServicesProvider>();

  Future<void> login() async {
    try {
      http.Response response = await apiServicesProvider.postRequestResponse(
          APIConstants.adminLogin,
          applyAuth: false,
          body: {
            "email": emailController.text,
            "password": passController.text
          });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        AdminModel adminModel = AdminModel.fromJson(data['user']);
        AppConstants.authToken = data['token'];
        currentAdmin = adminModel;
        HivePreferences.setIsLogin(true);
        HivePreferences.setAuthToken(data['token']);
        notifyListeners();
        ShowToastDialog.closeLoader();
        Get.offAll(() => SideBarScreen());
        AppFunctions.showToastMessage(message: "Login Successfully");
      } else if (response.statusCode == 401) {
        ShowToastDialog.closeLoader();
        AppFunctions.showToastMessage(message: "Invalid Credentials!");
      } else {
        ShowToastDialog.closeLoader();
        AppFunctions.showToastMessage(
            message: "Something went wrong: ${jsonDecode(response.body)}");
      }
    } catch (e) {
      print("EXCEPTION IN LOGIN FUNCTION $e");
      AppFunctions.showToastMessage(message: "Something went wrong: ${e}");
      ShowToastDialog.closeLoader();
    }
  }
}
