import 'dart:convert';

import 'package:chotu_admin/model/dashboard_analytics_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:chotu_admin/utils/toast_dialogue.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/api_consts.dart';
import 'api_services_provider.dart';

class DashboardProvider extends ChangeNotifier {


  ApiServicesProvider apiServicesProvider =
      navigatorKey.currentContext!.read<ApiServicesProvider>();

  DashboardAnalyticsModel? dashboardAnalyticsModel;

  Future<void> getDashboardAnalytics() async {
    try {
      await apiServicesProvider
          .getRequestResponse(APIConstants.getDashboardAnalytics)
          .then((response) {
        if (response.statusCode == 200) {
          print("FETCHED DASHBOARD ANALYTICS SUCCESS");
          var json = jsonDecode(response.body);
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
}
