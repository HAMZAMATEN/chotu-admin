import 'dart:convert';

import 'package:chotu_admin/model/dashboard_analytics_model.dart';
import 'package:chotu_admin/model/dashboard_settings_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:chotu_admin/utils/toast_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/api_consts.dart';
import '../utils/functions.dart';
import 'api_services_provider.dart';

import 'package:http/http.dart' as http;

class DashboardProvider extends ChangeNotifier {
  ApiServicesProvider apiServicesProvider =
      navigatorKey.currentContext!.read<ApiServicesProvider>();

  TextEditingController deliveryFeeCon = TextEditingController();
  TextEditingController googleLinkCon = TextEditingController();
  TextEditingController appleLinkCon = TextEditingController();

  DashboardAnalyticsModel? dashboardAnalyticsModel;
  DashboardSettingsModel? dashboardSettingsModel;

  Future<void> getDashboardAnalytics() async {
    try {
      await apiServicesProvider
          .getRequestResponse(APIConstants.getDashboardAnalytics)
          .then((response) {
        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);

          print("FETCHED DASHBOARD ANALYTICS SUCCESS:::");
          dashboardAnalyticsModel = DashboardAnalyticsModel.fromJson(json);

          notifyListeners();
        } else {
          var json = jsonDecode(response.body);

          print(
              "EXCEPTION WHILE GETTING DASHBOARD ANALYTICS WITH BODY:::$json AND STATUS::::${response.statusCode}");
        }
      });
    } catch (e) {
      print("EXCEPTION WHILE GETTING DASHBOARD ANALYTICS:::$e");
    }
  }

  void getDeliveryData() {
    if (dashboardSettingsModel != null) {
      deliveryFeeCon.text =
          dashboardSettingsModel?.data?.deliveryCharge.toString() ?? "";
      googleLinkCon.text =
          dashboardSettingsModel?.data?.playStoreLink.toString() ?? "";
      appleLinkCon.text =
          dashboardSettingsModel?.data?.appStoreLink.toString() ?? "";
      notifyListeners();
    }
  }

  Future<void> getDeliveryFeeSettings() async {
    try {
      await apiServicesProvider
          .getRequestResponse(APIConstants.getDashboardDeliverySettings)
          .then((response) {
        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);

          print("FETCHED DASHBOARD SETTINGS SUCCESS:::${json}");
          dashboardSettingsModel = DashboardSettingsModel.fromJson(json);

          getDeliveryData();
          notifyListeners();
        } else {
          var json = jsonDecode(response.body);

          print(
              "EXCEPTION WHILE GETTING DASHBOARD ANALYTICS WITH BODY:::$json AND STATUS::::${response.statusCode}");
        }
      });
    } catch (e) {
      print("EXCEPTION WHILE GETTING DASHBOARD ANALYTICS:::$e");
    }
  }

  Future<void> setDeliveryFeeSettings() async {
    ShowToastDialog.showLoader("Please Wait..");
    try {
      http.Response response = await apiServicesProvider.postRequestResponse(
          APIConstants.setDashboardDeliverySettings,
          applyAuth: true,
          body: {
            "delivery_charge": deliveryFeeCon.text,
            "play_store_link": googleLinkCon.text,
            "app_store_link": appleLinkCon.text,
          });

      if (response.statusCode == 200) {
        ShowToastDialog.closeLoader();
        AppFunctions.showToastMessage(message: "Settings saved successfully!");
      } else if (response.statusCode == 401) {
        ShowToastDialog.closeLoader();
        AppFunctions.showToastMessage(message: "Error while saving settings!");
      } else {
        ShowToastDialog.closeLoader();
        AppFunctions.showToastMessage(
            message: "Something went wrong: ${jsonDecode(response.body)}");
      }
    } catch (e) {
      print("EXCEPTION IN setDeliveryFee FUNCTION $e");
      AppFunctions.showToastMessage(message: "Something went wrong: ${e}");
      ShowToastDialog.closeLoader();
    }
  }
}
