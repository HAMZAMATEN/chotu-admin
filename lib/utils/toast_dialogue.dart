import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ShowToastDialog {
  static showToast(String? errorMessage,
      {EasyLoadingToastPosition position = EasyLoadingToastPosition.top}) {
    String message = extractErrorMessage(errorMessage!);
    EasyLoading.instance.userInteractions = true;
    //
    EasyLoading.showToast(
      message,
      toastPosition: position,
    );
    // EasyLoading.showInfo(message,duration: Duration(seconds: 3));
  }

  static showLoader(String message) {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show(status: message);
  }

  static closeLoader() {
    EasyLoading.dismiss();
  }

  static String extractErrorMessage(String error) {
    if (error.contains(']')) {
      return error.split(']').last.trim();
    }
    return error; // return the original error if no "]" is found
  }

  static funcShowSnackBar(BuildContext context, String messageStr) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 200,
        duration: Duration(seconds: 2),

        // padding: EdgeInsets.symmetric(horizontal: 10),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,

        content: Center(
            child: Text(
              messageStr,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
