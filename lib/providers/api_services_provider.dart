import 'dart:convert';

import 'package:chotu_admin/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiServicesProvider extends ChangeNotifier {
  Future<http.Response> getRequestResponse(String url) async {
    http.Response? response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${AppConstants.authToken}',
      },
    );

    // if (response.statusCode == 401) {
    //   AppFunctions.showToastMessage(message: "Session Expired!");
    //   Get.offAll(() => LoginView());
    // }
    return response;
  }

  Future<http.Response> postRequestResponse(String url,
      {Map<String, dynamic>? body, bool? applyAuth = true}) async {
    http.Response? response = await http.post(
      Uri.parse(url),
      headers: (applyAuth! == true)
          ? {
              'Authorization': 'Bearer ${AppConstants.authToken}',
              'Content-Type': 'application/json',
            }
          : {
              'Content-Type': 'application/json',
            },
      body: body != null ? jsonEncode(body) : null,
    );

    // if (response.statusCode == 401) {
    //   AppFunctions.showToastMessage(message: "Session Expired!");
    //   Get.offAll(() => LoginView());
    // }
    return response;
  }


  Future<http.Response> putRequestResponse(String url,
      {Map<String, dynamic>? body, bool? applyAuth = true}) async {
    http.Response? response = await http.put(
      Uri.parse(url),
      headers: (applyAuth! == true)
          ? {
        'Authorization': 'Bearer ${AppConstants.authToken}',
        'Content-Type': 'application/json',
      }
          : {
        'Content-Type': 'application/json',
      },
      body: body != null ? jsonEncode(body) : null,
    );

    // if (response.statusCode == 401) {
    //   AppFunctions.showToastMessage(message: "Session Expired!");
    //   Get.offAll(() => LoginView());
    // }
    return response;
  }


  Future<http.Response> deleteRequestResponse(String url) async {
    http.Response? response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${AppConstants.authToken}',
      },
    );

    // if (response.statusCode == 401) {
    //   AppFunctions.showToastMessage(message: "Session Expired!");
    //   Get.offAll(() => LoginView());
    // }
    return response;
  }
}
